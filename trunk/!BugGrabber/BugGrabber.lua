--
-- $Id: BugGrabber.lua 64142 2008-03-10 15:42:54Z kunda $
--

--[[

BugGrabber, World of Warcraft addon that catches errors and formats them with a debug stack.
Copyright (C) 2007 The BugGrabber Team

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

]]

MAX_BUGGRABBER_ERRORS = 1000

-- If we get more errors than this per second, we stop all capturing until the
-- user tells us to continue.
BUGGRABBER_ERRORS_PER_SEC_BEFORE_THROTTLE = 20
BUGGRABBER_TIME_TO_RESUME = 60
BUGGRABBER_SUPPRESS_THROTTLE_CHAT = nil

-- Localization
local CMD_CREATED = "An error has been detected, use /buggrabber to print it."
local USAGE = "Usage: /buggrabber <1-%d>."
local ERROR_INDEX = "The provided index must be a number."
local ERROR_UNKNOWN_INDEX = "The index %d does not exist in the load error table."
local STARTUP_ERRORS = "There were %d startup errors:"
local STARTUP_ERRORS_MANY = "There were %d startup errors, please use /buggrabber <number> to print them."
local UNIQUE_CAPTURE = "BugGrabber captured a unique error:\n%s\n---"
local ADDON_CALL_PROTECTED = "[%s] AddOn '%s' tried to call the protected function '%s'."
local ADDON_CALL_PROTECTED_MATCH = "^%[(.*)%] (AddOn '.*' tried to call the protected function '.*'.)$"
local ADDON_DISABLED = "|cffffff7fBugGrabber|r and |cffffff7f%s|r cannot coexist together. |cffffff7f%s|r has been disabled because of this. If you want to, you may exit out, disable |cffffff7fBugGrabber|r and reenable |cffffff7f%s|r."
local BUGGRABBER_STOPPED = "|cffffff7fBugGrabber|r has stopped capturing errors, since it has captured more than %d errors per second. Capturing will resume in %d seconds."
local BUGGRABBER_RESUMING = "|cffffff7fBugGrabber|r is capturing errors again."

if GetLocale() == "koKR" then
	USAGE = "사용법: /buggrabber <1-%d>."
	ERROR_INDEX = "색인값은 숫자이어야 합니다."
	ERROR_UNKNOWN_INDEX = "불러온 오류목록에 %d번째 오류는 존재하지 않습니다."
	STARTUP_ERRORS = "%d개의 시작시 오류가 발생:"
	STARTUP_ERRORS_MANY = "%d개의 시작시 오류가 발생했습니다, /buggrabber <숫자>를 사용해서 해당 오류를 볼 수 있습니다."
	UNIQUE_CAPTURE = "벌레잡이가 발견한 오류:\n%s\n---"
elseif GetLocale() == "deDE" then
	CMD_CREATED = "Ein Fehler wurde entdeckt, benutze /buggrabber um ihn anzuzeigen."
	USAGE = "Benutzung: /buggrabber <1-%d>."
	ERROR_INDEX = "Der zur Verfügung gestellte Index muß eine Zahl sein."
	ERROR_UNKNOWN_INDEX = "Der Index %d existiert nicht in der geladenen Fehlerliste."
	STARTUP_ERRORS = "Es gab %d Fehler beim Start:"
	STARTUP_ERRORS_MANY = "Es gab %d Fehler beim Start, verwende bitte /buggrabber <nummer> um sie aufzulisten."
	UNIQUE_CAPTURE = "BugGrabber hat einen einzigartigen Error aufgezeichnet:\n%s\n---"
	--ADDON_CALL_PROTECTED = "[%s] AddOn '%s' hat versucht die geschützte Funktion '%s' aufzurufen."
	--ADDON_CALL_PROTECTED_MATCH = "^%[(.*)%] (AddOn '.*' hat versucht die geschützte Funktion '.*' aufzurufen.)$"
	ADDON_DISABLED = "|cffffff7fBugGrabber|r und |cffffff7f%s|r können nicht zusammen laufen, |cffffff7f%s|r wurde deshalb deaktiviert. Wenn Du möchtest, kann du WoW nun schließen, |cffffff7fBugGrabber|r deaktivieren und |cffffff7f%s|r erneut aktivieren."
	BUGGRABBER_STOPPED = "|cffffff7fBugGrabber|r hat die Aufzeichnung von Fehlern gestoppt, weil mehr als %d Fehler pro Sekunde erzeugt wurden. Die Aufzeichnung wird in %d Sekunden fortgesetzt."
	BUGGRABBER_RESUMING = "|cffffff7fBugGrabber|r zeichnet nun wieder Fehler auf."
elseif GetLocale() == "esES" then
	USAGE = "Uso: /buggrabber <1-%d>."
	ERROR_INDEX = "El \195\173ndice introducido debe ser un n\195\186mero."
	ERROR_UNKNOWN_INDEX = "El \195\173ndice %d no existe en la tabla de errores de carga."
	STARTUP_ERRORS = "Ha habido %d errores de arranque:"
	STARTUP_ERRORS_MANY = "Ha habido %d errores de arranque, por favor, usa /buggrabber <number> para listarlos."
	UNIQUE_CAPTURE = "BugGrabber ha capturado un \195\186nico error:\n%s\n---"
	ADDON_CALL_PROTECTED = "[%s] El accesorio '%s' ha intentado llamar a la funci\195\179n protegida '%s'."
	ADDON_CALL_PROTECTED_MATCH = "^%[(.*)%] (El accesorio '.*' ha intentado llamar a la funci\195\179n protegida '.*'.)$"
elseif GetLocale() == "zhTW" then
	CMD_CREATED = "發現錯誤，用 /buggrabber 列出這錯誤。"
	USAGE = "用法：/buggrabber <1-%d>。"
	ERROR_INDEX = "提供的索引值必須是數字。"
	ERROR_UNKNOWN_INDEX = "提供的索引值「%d」不是正確的。"
	STARTUP_ERRORS = "在啟動時發生%d個錯誤:"
	STARTUP_ERRORS_MANY = "在啟動時發生%d個錯誤，請使用 /buggrabber <索引值> 來列出。"
	UNIQUE_CAPTURE = "捕捉到新的錯誤:\n%s\n---"
--	no need to translate ADDON_CALL_PROTECTED
--	no need to translate ADDON_CALL_PROTECTED_MATCH
	ADDON_DISABLED = "|cffffff7fBugGrabber|r 和 |cffffff7f%s|r 不能共存。|cffffff7f%s|r 已停用。你可在插件介面停用 |cffffff7fBugGrabber|r，再用 |cffffff7f%s|r。"
	BUGGRABBER_STOPPED = "|cffffff7fBugGrabber|r 現正暫停，因為每秒捕捉到超過%d個錯誤。它會在%d秒後重新開始。"
	BUGGRABBER_RESUMING = "|cffffff7fBugGrabber|r 已重新開始。"
end

-- Create our event registering frame
local BugGrabber = CreateFrame("Frame", "BugGrabber")

local slashCmdCreated = nil
local temporaryList = nil
local real_seterrorhandler = seterrorhandler
local real_geterrorhandler = geterrorhandler
local eventLibrary = nil
local totalElapsed = 0

local errorsSinceLastReset = 0
local paused = nil
local looping = false

-- State variables
BugGrabber.loaded = false
BugGrabber.loadErrors = {}
BugGrabber.bugsackErrors = {}
BugGrabber.errors = {}

-- Our persistent error database
BugGrabberDB = {}
BugGrabberDB.session = 0
BugGrabberDB.save = true
BugGrabberDB.limit = math.ceil(MAX_BUGGRABBER_ERRORS / 2)
BugGrabberDB.errors = {}
BugGrabberDB.throttle = true

-- Determine the proper DB and return it
function BugGrabber.GetDB()
	if not BugGrabber.loaded then
		return BugGrabber.loadErrors
	end
	if not BugGrabberDB.save then
		return BugGrabber.errors
	end
	return BugGrabberDB.errors
end

-- Error handler
function BugGrabber.GrabError(err)
	if paused then return end

	-- Get the full backtrace
	local real = err:find("^.-([^\\]+\\)([^\\]-)(:%d+):(.*)$") or err:find("^%[string \".-([^\\]+\\)([^\\]-)\"%](:%d+):(.*)$") or err:find("^%[string (\".-\")%](:%d+):(.*)$") or err:find("^%[C%]:(.*)$")
	err = err .. "\n" .. debugstack(real and 4 or 3)
	local errorType = "error"

	-- Normalize the full paths into last directory component and filename.
	local errmsg = ""
	looping = false

	for trace in err:gmatch("(.-)\n") do
		local match, found, path, file, line, msg, _
		found = false

		-- First detect an endless loop so as to abort it below
		if trace:find("BugGrabber") then
			looping = true
		end

		-- "path\to\file-2.0.lua:linenum:message" -- library
		if not found then
			match, _, path, file, line, msg = trace:find("^.-([^\\]+\\)([^\\]-%-%d+%.%d+%.lua)(:%d+):(.*)$")
			local addon = trace:match("^.-[A%.][d%.][d%.][Oo]ns\\([^\\]-)\\")
			if match then
				local good = false
				if AceLibrary then
					local lib = file:gsub("%.lua$", "")
					if AceLibrary:HasInstance(lib, false) then
						lib = AceLibrary(lib)
						if type(rawget(lib, "GetLibraryVersion")) == "function" then
							local success, major, minor = pcall(lib.GetLibraryVersion, lib)
							if success then
								path = major .. "-" .. (minor or "?")
								if addon then
									file = " (" .. addon .. ")"
								else
									file = ""
								end
								good = true
							end
						end
					end
				end
				if not good and Rock then
					local lib = file:gsub("%.lua$", "")
					lib = Rock(lib, true, true)
					if lib and type(rawget(lib, "GetLibraryVersion")) == "function" then
						local success, major, minor = pcall(lib.GetLibraryVersion, lib)
						if success then
							path = major .. "-" .. (minor or "?")
							if addon then
								file = " (" .. addon .. ")"
							else
								file = ""
							end
							good = true
						end
					end
				end
				found = true
			end
		end
		
		-- "Interface\AddOns\path\to\file.lua:linenum:message"
		if not found then
			match, _, path, file, line, msg = trace:find("^.-[A%.][d%.][d%.][Oo]ns\\(.*)([^\\]-)(:%d+):(.*)$")
			if match then
				found = true
				local addon = path:gsub("\\.*$", "")
				local _G_addon = _G[addon]
				if not _G_addon then
					_G_addon = _G[addon:match("^[^_]+_(.*)$")]
				end
				local version = ""
				if type(_G_addon) == "table" then
					if rawget(_G_addon, "version") then version = _G_addon.version
					elseif rawget(_G_addon, "Version") then version = _G_addon.Version
					elseif rawget(_G_addon, "VERSION") then version = _G_addon.VERSION
					end
					if type(version) == "function" then version = tostring(select(2, pcall(version()))) end
					local revision = nil
					if rawget(_G_addon, "revision") then revision = _G_addon.revision
					elseif rawget(_G_addon, "Revision") then revision = _G_addon.Revision
					elseif rawget(_G_addon, "REVISION") then revision = _G_addon.REVISION
					elseif rawget(_G_addon, "rev") then revision = _G_addon.rev
					elseif rawget(_G_addon, "Rev") then revision = _G_addon.Rev
					elseif rawget(_G_addon, "REV") then revision = _G_addon.REV
					end
					if type(revision) == "function" then revision = tostring(select(2, pcall(revision()))) end

					if version then version = tostring(version) end
					if revision then revision = tostring(revision) end
					if type(revision) == "string" and type(version) == "string" and version:len() > 0 and not version:find(revision) then
						version = version .. "." .. revision
					end

					if not version and revision then version = revision end
				end
				
				if _G[addon:upper().."_VERSION"] then
					version = _G[addon:upper() .. "_VERSION"]
				end
				if _G[addon:upper().."_REVISION"] or _G[addon:upper().."_REV"] then
					local revision = _G[addon:upper() .. "_REVISION"] or _G[addon:upper().."_REV"]
					if type(revision) == "string" and type(version) == "string" and version:len() > 0 and not version:find(revision) then
						version = version .. "." .. revision
					end
					if not version and revision then version = revision end
				end
				
				if not version and AceLibrary and AceLibrary:HasInstance(addon) then
					local _, rev = AceLibrary(addon)
					version = rev
				end
				
				if not version then
					version = GetAddOnMetadata(addon, "Version")
				end
				
				if type(version) == "string" and version:len() > 0 or type(version) == "number" then
					path = addon .. "-" .. tostring(version) .. path:gsub("^[^\\]*", "")
				end
			end
		end
		
		-- "path\to\file.lua:linenum:message"
		if not found then
			match, _, path, file, line, msg = trace:find("^.-([^\\]+\\)([^\\])(:%d+):(.*)$")
			if match then
				found = true
			end
		end

		-- "[string \"path\\to\\file.lua:<foo>\":linenum:message"
		if not found then
			match, _, path, file, line, msg = trace:find("^%[string \".-([^\\]+\\)([^\\]-)\"%](:%d+):(.*)$")
			if match then
				found = true
			end
		end

		-- "[string \"FOO\":linenum:message"
		if not found then
			match, _, file, line, msg = trace:find("^%[string (\".-\")%](:%d+):(.*)$")
			if match then
				found = true
				path = '<string>:'
			end
		end

		-- "[C]:message"
		if not found then
			match, _, msg = trace:find("^%[C%]:(.*)$")
			if match then
				found = true
				path = '<in C code>'
				file = ''
				line = ''
			end
		end

		-- ADDON_ACTION_BLOCKED
		if not found then
			match, _, file, msg = trace:find(ADDON_CALL_PROTECTED_MATCH)
			if match then
				found = true
				path = '<event>'
				file = 'ADDON_ACTION_BLOCKED'
				line = ''
				errorType = "event"
			end
		end

		-- Anything else
		if not found then
			path = trace--'<unknown>'
			file = ''
			line = ''
			msg = line
		end

		-- Add it to the formatted error
		errmsg = errmsg .. path .. file .. line .. ":" .. msg .. "\n"
	end

	errorsSinceLastReset = errorsSinceLastReset + 1

	-- Now store the error
	BugGrabber.SaveError(errmsg, errorType)
end

function BugGrabber.SaveError(message, errorType)
	-- Start with the date, time and session
	local oe = {}
	oe.message = message .. "\n  ---"
	oe.session = BugGrabberDB.session
	oe.time = date("%Y/%m/%d %H:%M:%S")
	oe.type = errorType
	oe.counter = 1

	-- WoW crashes when strings > 983 characters are stored in the
	-- SavedVariables file, so make sure we don't exceed that limit.
	-- For lack of a better thing to do, just truncate the error :-/
	if oe.message:len() > 980 then
		local m = oe.message
		oe.message = {}
		local maxChunks, chunks = 5, 0
		while m:len() > 980 and chunks <= maxChunks do
			local q
			q, m = m:sub(1, 980), m:sub(981)
			table.insert(oe.message, q)
			chunks = chunks + 1
		end
		if m:len() > 980 then m = m:sub(1, 980) end
		table.insert(oe.message, m)
	end

	local added = false

	-- Insert the error into the correct database if it's not there already.
	-- If it is, just increment the counter.
	local found = false
	local db = BugGrabber.GetDB()
	local oe_message = oe.message
	if type(oe_message) == "table" then
		oe_message = oe_message[1]
	end
	local i, err
	for i, err in ipairs(db) do
		local err_message = err.message
		if type(err_message) == "table" then
			err_message = err_message[1]
		end
		if err_message == oe_message and err.session == oe.session then
			-- This error already exists in the current session, just increment
			-- the counter on it.
			if not err.counter or type(err.counter) ~= "number" then
				err.counter = 1
			end
			err.counter = err.counter + 1

			-- Update the current error for the event firing later.
			oe.counter = err.counter
			oe.time = err.time
			found = true
			break
		end
	end

	-- If the error was not found in the current session, append it to the
	-- database.
	if not found then
		table.insert(db, oe)
		added = true
	end

	-- Also insert it into the temporary capture database that we maintain
	-- to silence loading errors while we wait for BugSack to load
	if type(BugGrabber.bugsackErrors) == "table" then
		found = false
		for i, err in ipairs(BugGrabber.bugsackErrors) do
			local err_message = err.message
			if type(err_message) == "table" then
				err_message = err_message[1]
			end
			if err_message == oe_message and err.session == oe.session then
				if not err.counter or type(err.counter) ~= "number" then
					err.counter = 1
				end
				err.counter = err.counter + 1
				found = true
				break
			end
		end
		if not found then
			table.insert(BugGrabber.bugsackErrors, oe)
			added = true
		end
	end

	-- Save only the last <limit> errors (otherwise the SV gets too big)
	if #db > BugGrabberDB.limit then
		table.remove(db, 1)
	end

	-- Now trigger an event if someone's listening. If not, just print
	-- it to the chat frame so it doesn't get lost.
	if not looping and not BugGrabber.bugsackErrors then
		if not eventLibrary then eventLibrary = AceLibrary and AceLibrary:HasInstance("AceEvent-2.0") and AceLibrary("AceEvent-2.0") or nil end
		if eventLibrary and eventLibrary:IsEventRegistered("BugGrabber_BugGrabbed") then
			local prefix = "Bug"
			if errorType == "event" then prefix = "Event" end
			if added then
				eventLibrary:TriggerEvent("BugGrabber_"..prefix.."Grabbed", oe)
			else
				eventLibrary:TriggerEvent("BugGrabber_"..prefix.."GrabbedAgain", oe)
			end
		elseif added then
			BugGrabber.CreateSlashCmd()
			if not temporaryList then temporaryList = {} end
			table.insert(temporaryList, oe)
		end
	end
end

local onUpdateFunction = function(_, elapsed)
	totalElapsed = totalElapsed + elapsed
	if totalElapsed > 1 then
		if not paused then
			-- Seems like we're getting more errors/sec than we want.
			if errorsSinceLastReset > BUGGRABBER_ERRORS_PER_SEC_BEFORE_THROTTLE then
				BugGrabber.Pause()
			end
			errorsSinceLastReset = 0
			totalElapsed = 0
		elseif totalElapsed > BUGGRABBER_TIME_TO_RESUME and paused then
			BugGrabber.Resume()
		end
	end
end

-- Event handlers
function BugGrabber.AddonLoaded()
	BugGrabber.loaded = true

	-- Persist defaults and make sure we have sane SavedVariables
	if not BugGrabberDB or type(BugGrabberDB) ~= "table" then
		BugGrabberDB = {}
	end
	if not BugGrabberDB.session or type(BugGrabberDB.session) ~= "number" then
		BugGrabberDB.session = 0
	end
	if not BugGrabberDB.errors or type(BugGrabberDB.errors) ~= "table" then
		BugGrabberDB.errors = {}
	end
	if not BugGrabberDB.limit or type(BugGrabberDB.limit) ~= "number" then
		BugGrabberDB.limit = 100
	end
	if BugGrabberDB.save == nil or type(BugGrabberDB.save) ~= "boolean" then
		BugGrabberDB.save = true
	end
	if BugGrabberDB.throttle == nil or type(BugGrabberDB.throttle) ~= "boolean" then
		BugGrabberDB.throttle = true
	end

	-- From now on we can persist errors. Create a new session.
	BugGrabberDB.session = BugGrabberDB.session + 1

	-- Determine the correct database
	local db = BugGrabber.GetDB()

	-- Cut down on the nr of errors if it is over 100
	while #db + #BugGrabber.loadErrors > BugGrabberDB.limit do
		table.remove(db, 1)
	end

	-- Save the errors that occurred while our variables were loading
	-- in the correct database.
	local _, err
	for _,err in pairs(BugGrabber.loadErrors) do
		err.session = BugGrabberDB.session
		table.insert(db, err)
	end

	if BugGrabberDB.throttle then
		BugGrabber:SetScript("OnUpdate", onUpdateFunction)
	end

	-- Now do away with the temporary database
	BugGrabber.loadErrors = nil
end

function BugGrabber.PrintLoadError(index)
	if not index or tostring(index) == "" then
		BugGrabber.Print(USAGE:format(temporaryList and #temporaryList or 1))
		return
	end
	if not tonumber(index) then
		BugGrabber.Print(ERROR_INDEX)
		return
	end
	index = tonumber(index)
	if not temporaryList or not temporaryList[index] then
		BugGrabber.Print(ERROR_UNKNOWN_INDEX:format(index))
		return
	end
	local err = temporaryList[index]
	if type(err) ~= "table" or (type(err.message) ~= "string" and type(err.message) ~= "table") then return end
	if BugSack and type(BugSack.FormatError) == "function" then
		BugGrabber.Print(tostring(index) .. ". " .. BugSack:FormatError(err))
	else
		local m = err.message
		if type(m) == "table" then
			m = table.concat(m, '')
		end
		BugGrabber.Print(tostring(index) .. ". " .. m)
	end
end

function BugGrabber.CreateSlashCmd()
	if slashCmdCreated then return end
	BugGrabber.Print(CMD_CREATED)
	local name = "BUGGRABBERCMD"
	local counter = 0
	repeat
		name = "BUGGRABBERCMD"..tostring(counter)
		counter = counter + 1
	until not _G.SlashCmdList[name] and not _G["SLASH_"..name.."1"]
	_G.SlashCmdList[name] = BugGrabber.PrintLoadError
	_G["SLASH_"..name.."1"] = "/buggrabber"

	slashCmdCreated = true
end

function BugGrabber.PlayerLogin()
	-- On player login, check to see whether we had load time errors and
	-- display them in the chat frame if we can't find BugSack. We cheat
	-- by letting BugSack reset BugGrabber.bugsackErrors so we can just
	-- check that.
	local err = BugGrabber.bugsackErrors
	if type(err) == "table" and #err > 0 then
		local num = #err
		local _G = getfenv(0)
		if num > 4 and type(_G.SlashCmdList) == "table" then
			BugGrabber.Print(STARTUP_ERRORS_MANY:format(num))
			if not temporaryList then temporaryList = {} end
			local _, v
			for _, v in ipairs(err) do
				table.insert(temporaryList, v)
			end
			BugGrabber.CreateSlashCmd()
		else
			BugGrabber.Print(STARTUP_ERRORS:format(num))
			local k, e
			for k, e in ipairs(err) do
				if BugSack and type(BugSack.FormatError) == "function" then
					BugGrabber.Print(tostring(k) .. ". " .. BugSack:FormatError(e))
				else
					local m = e.message
					if type(m) == "table" then
						m = table.concat(m, '')
					end
					BugGrabber.Print(tostring(k) .. ". " .. m)
				end
			end
		end
	end

	-- No need to wait for BugSack to load anymore
	BugGrabber.bugsackErrors = nil
end

function BugGrabber.OnEvent()
	if event == "ADDON_LOADED" then
		if arg1 == "!BugGrabber" then
			real_seterrorhandler(BugGrabber.GrabError)
			BugGrabber.AddonLoaded()
		elseif (arg1 == "!Swatter" or (type(SwatterData) == "table" and SwatterData.enabled)) and Swatter then
			BugGrabber.Print(string.gsub(ADDON_DISABLED, "%%s", "Swatter"))
			DisableAddOn("!Swatter")
			SwatterData.enabled = nil
			real_seterrorhandler(BugGrabber.GrabError)
			SlashCmdList.SWATTER = nil
			SLASH_SWATTER1, SLASH_SWATTER2 = nil, nil
			for k, v in pairs(Swatter) do
				if type(v) == "table" and rawget(v, 0) and v.GetFrameType then
					v:UnregisterEvent("ADDON_ACTION_FORBIDDEN")
					v:UnregisterEvent("ADDON_ACTION_BLOCKED")
				end
			end
		elseif arg1 == "Stubby" then
			-- Need this so Stubby will feed us errors instead of just
			-- dumping them to the chat frame.
			_G.Swatter = {
				IsEnabled = function() return true end,
				OnError = function(msg, frame, stack, etype, ...)
					BugGrabber.GrabError(tostring(msg) .. tostring(stack))
				end,
			}
		end
	elseif event == "PLAYER_LOGIN" then	
		real_seterrorhandler(BugGrabber.GrabError)
		BugGrabber.PlayerLogin()
	elseif event == "ADDON_ACTION_BLOCKED" or event == "ADDON_ACTION_FORBIDDEN" then
		BugGrabber.GrabError(ADDON_CALL_PROTECTED:format(event, arg1, arg2))
	end
end

-- Simple setters/getters for settings, meant to be accessed by BugSack
function BugGrabber.GetSave()
	return BugGrabberDB.save
end

function BugGrabber.ToggleSave()
	BugGrabberDB.save = not BugGrabberDB.save
	if BugGrabberDB.save then
		BugGrabberDB.errors = BugGrabber.errors
		BugGrabber.errors = {}
	else
		BugGrabber.errors = BugGrabberDB.errors
		BugGrabberDB.errors = {}
	end
end

function BugGrabber.GetLimit()
	return BugGrabberDB.limit
end

function BugGrabber.SetLimit(l)
	if type(l) ~= "number" or l < 10 or l > MAX_BUGGRABBER_ERRORS then
		return
	end

	BugGrabberDB.limit = math.floor(l)

	local db = BugGrabber.GetDB()
	while #db > l do
		table.remove(db, 1)
	end
end

function BugGrabber.IsThrottling()
	return BugGrabberDB.throttle
end

function BugGrabber.UseThrottling(flag)
	BugGrabberDB.throttle = flag and true or false
	if flag and BugGrabber:GetScript("OnUpdate") == nil then
		BugGrabber:SetScript("OnUpdate", onUpdateFunction)
	elseif not flag then
		BugGrabber:SetScript("OnUpdate", nil)
	end
end

function BugGrabber.Print(text)
	if type(DEFAULT_CHAT_FRAME) == "table" and type(DEFAULT_CHAT_FRAME.AddMessage) == "function" then
		DEFAULT_CHAT_FRAME:AddMessage(text)
	end
end

function BugGrabber.RegisterAddonActionEvents()
	BugGrabber:RegisterEvent("ADDON_ACTION_BLOCKED")
	BugGrabber:RegisterEvent("ADDON_ACTION_FORBIDDEN")
	if not eventLibrary then eventLibrary = AceLibrary and AceLibrary:HasInstance("AceEvent-2.0") and AceLibrary("AceEvent-2.0") or nil end
	if eventLibrary then eventLibrary:TriggerEvent("BugGrabber_AddonActionEventsRegistered") end
end

function BugGrabber.UnregisterAddonActionEvents()
	BugGrabber:UnregisterEvent("ADDON_ACTION_BLOCKED")
	BugGrabber:UnregisterEvent("ADDON_ACTION_FORBIDDEN")
	if not eventLibrary then eventLibrary = AceLibrary and AceLibrary:HasInstance("AceEvent-2.0") and AceLibrary("AceEvent-2.0") or nil end
	if eventLibrary then eventLibrary:TriggerEvent("BugGrabber_AddonActionEventsUnregistered") end
end

function BugGrabber.IsPaused()
	return paused
end

function BugGrabber.Pause()
	if paused then return end

	if not BUGGRABBER_SUPPRESS_THROTTLE_CHAT then
		BugGrabber.Print(string.format(BUGGRABBER_STOPPED, BUGGRABBER_ERRORS_PER_SEC_BEFORE_THROTTLE, BUGGRABBER_TIME_TO_RESUME))
	end
	BugGrabber.UnregisterAddonActionEvents()
	paused = true
	if eventLibrary then
		eventLibrary:TriggerEvent("BugGrabber_CapturePaused")
	end
end

function BugGrabber.Resume()
	if not paused then return end

	if not BUGGRABBER_SUPPRESS_THROTTLE_CHAT then
		BugGrabber.Print(BUGGRABBER_RESUMING)
	end
	BugGrabber.RegisterAddonActionEvents()
	paused = nil
	if eventLibrary then
		eventLibrary:TriggerEvent("BugGrabber_CaptureResumed")
	end
	totalElapsed = 0
end

-- Now register for our needed events
BugGrabber:RegisterEvent("ADDON_LOADED")
BugGrabber:RegisterEvent("PLAYER_LOGIN")
BugGrabber.RegisterAddonActionEvents()
BugGrabber:SetScript("OnEvent", BugGrabber.OnEvent)

real_seterrorhandler(BugGrabber.GrabError)
function seterrorhandler() --[[ noop ]] end

-- vim:set ts=4:
