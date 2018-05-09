--[[
	JCR6
	File acceptor and processor
	
	
	
	(c) Jeroen P. Broks, 2018, All rights reserved
	
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
		
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
		
	Exceptions to the standard GNU license are available with Jeroen's written permission given prior 
	to the project the exceptions are needed for.
Version: 18.05.09
]]

-- $USE libs/path

local debug = true

local loading = LoadImage("LoadingAnalysing.png");HotCenter(loading)
local ficon_directory=LoadImage("ficons/directory.png"); assert(ficon_directory and ficon_directory.images,"error in loading needed icon")

function PutInList(d)
    -- locals
    local ud=d:upper()
    local addicon
    local havedirs={}
    
    boxes.files:Clear()
    -- Directories
    for k,_ in spairs(wjcr.entries) do
        local fulldir=ExtractDir(k)
        local sdir=path.SplitDir(fulldir)
        local dir = ""
        for sd in each(sdir) do
            if #dir>0 then dir=dir.."/" end
            dir=dir..sd
            if debug then print(string.char(27).."[33mFound dir:  "..string.char(27).."[0m"..dir) end
            if dir~="" and not havedirs[dir] then 
               havedirs[dir]=true
               --local pdir = left(dir,#dir-1) -- no longer needed
               if ExtractDir(dir)==ud then  
                  boxes.files:Add(StripDir(dir.."/"),ficon_directory)
                  if debug then print(string.char(27).."[34mAdded dir:  "..string.char(27).."[0m"..dir) end
               end
           end
        end
    end    
    
    -- Files
    for k,e in spairs(wjcr.entries) do -- If I don't do it this way, all directories would be at the bottom, but I want them on top!
        if ExtractDir(k)==ud then
           boxes.files:Add(StripDir(e.entry),addicon)
           if debug then print(string.char(27).."[32mAdded file: "..string.char(27).."[0m"..e.entry) end
        end 
    end
end

function maan.accept(file,filetype)
    -- Loading
    love.graphics.clear()
    local w,h=love.graphics.getDimensions()
    DrawImage(loading,w/2,h/2)
    love.graphics.present()
    -- Debug
    print("Accepted "..filetype..": "..file) -- debug!
    -- Read the JCR file
    wjcr = JCR_Dir(file)
    -- error handling
    if not wjcr then
       throw("Reading JCR file failed\n\n"..JCR_Error)
       return
    end
    -- Relation check
    
    -- Put everything in the file list gadgets
    PutInList("")
    
    
    -- Show the file list screen
    GoScreen('fileviewer')
end    
