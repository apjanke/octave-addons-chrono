## Copyright (C) 2019 Andrew Janke <floss@apjanke.net>
##
## This file is part of Octave.
##
## Octave is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## Octave is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <https://www.gnu.org/licenses/>.

function out = slurpTextFile (file)
  %SLURPTEXTFILE Read a file's contents as text.
  [fid, msg] = fopen (file, 'r');
  if fid == -1
    error ('Could not open file %s: %s', file, msg);
  end
  cleanup.fid = onCleanup (@() fclose (fid));
  txt = fread (fid, Inf, 'char=>char');
  txt = txt';
  out = txt;
endfunction