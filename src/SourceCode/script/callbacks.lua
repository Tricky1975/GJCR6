--[[
	JCR6
	Callbacks
	
	
	
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
Version: 18.05.12
]]
-- $USE libs/maneschijn
-- $USE libs/path

-- $IF IGNORE
local maan={}
-- $FI

function maan.filelist_Action(gadget,selections,keuze)
    if not keuze then return end
    local f=gadget:ItemText(keuze)
    if right(f,1)~="/" then return end
    if f=="../" then
       local pdf=ExtractDir(left(f,#f-1))
       PutInList(pdf)
       return
    end
    wcurrentdir=wcurrentdir..f
    gadget:Clear()
    PutInList(wcurrentdir)
end

function maan.fileinfo_Action(gadget)
    local s = boxes.files:selecteditems()
    local i = s[1]
    if not i then return end
    local f = wcurrentdir..boxes.files:ItemText(i)
    if suffixed(f,"/") then
       local cnt=0
       for k,_ in pairs(wjcr.entries) do
           if ExtractDir(k)==f then cnt = cnt + 1 end
       end
       notify("Directory:\t"..f.."\n\nFiles:\t"..cnt)
       return
    end
    -- Gather entry data
    local fields = {
        {'File:\t\t','entry','%s'},
        {'Type:\t',"!TYPE",'%s'},
        {'Main:\t','mainfile','%s'},
        {'Size:\t\t','size','%9d'},
        {'Comp:\t','compressedsize','%9d'},
        {'Ratio:\t','!RATIO','%3d%%'},
        {'Algorithm:\t','storage','%s'},
        {'Offset:\t','offset','%X'},
        {'Author:\t',"author",'%s'},
        {"\nNotes:\n","notes","%s"}}
    local mb=""
    local entry=wjcr.entries[f:upper()]    
    for fld in each(fields) do
        local value=entry[fld[2]]
        if fld[2]=="!RATIO" then value=math.floor(((entry.compressedsize/entry.size)*100)+.5) end
        if fld[2]=='!TYPE' then value=FileType(f) end
        mb=mb..fld[1]..fld[3]:format(value).."\n"
    end
    -- Gather relations (aliases)
    
    -- Output result
    notify(mb)        
end


function maan.fileview_Action(gadget)
    local s = boxes.files:selecteditems()
    local i = s[1]
    if not i then return end
    local f = wcurrentdir..boxes.files:ItemText(i)
    if suffixed(f,"/") then
       maan.fileinfo_Action(gadget)
       return
    end
    -- $USE script/view
    view(f)   
end
