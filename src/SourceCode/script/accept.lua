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
function maan.accept(file,filetype)
    -- Debug
    print("Accepted "..filetype..": "..file) -- debug!
    -- Read the JCR file
    wjcr = JCR_Dir(file)
    -- error handling
    if not wjcr then
       throw("Reading JCR file failed\n\n"..JCR_Error)
       return
    end
    -- Put everything in the file list gadgets
    
    -- Show the file list screen
    GoScreen('fileviewer')
end    
