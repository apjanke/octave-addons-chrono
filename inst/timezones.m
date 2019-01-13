function out = timezones(area)
  %TIMEZONES List time zones
  %
  % timezones
  % timezones(area)
  % T = (...)
  %
  % Lists all the time zones available on this system.
  %
  % If the return is captured, the list is returned as a table if your Octave
  % has table support, or a struct if it does not. It will have fields/variables:
  %   Name
  %   Area
  %
  % Compatibility note: Matlab also includes UTCOffset and DSTOffset fields in
  % the output; these are currently unimplemented here.
  
  tzdb = octave.time.internal.tzinfo.TzDb;
  ids = tzdb.definedZones;
  ids = ids(:);
  areas = cell(size(ids));
  for i = 1:numel(ids)
    if any(ids{i} == '/')
      area = regexprep(ids{i}, '/.*', '');
    else
      area = '';
    end
    areas{i} = area;
  end
  
  if nargin > 0
    tf = strcmp(out.Area, area);
    ids = ids(tf);
    areas = areas(tf);
  end

  if octave_has_table
    out = table(ids, areas, 'VariableNames',{'Name','Area'});
  else
    out = struct;
    out.Name = ids;
    out.Area = areas;
  end
  
  if nargout == 0
    if octave_has_table
      % This assumes you're using apjanke's octave-addons-table implementation
      prettyprint(out);
    else
      fmt = '  %-32s  %-20s\n';
      fprintf(fmt, 'Name', 'Area');
      fprintf(fmt, repmat('-', [1 32]), repmat('-', [1 20]));
      for i = 1:numel(out.Name)
        fprintf(fmt, out.Name{i}, out.Area{i});
      end
    end
    clear out
  end
  
end

function out = octave_has_table
  persistent cache
  if isempty(cache)
    try
      t = table;
      cache = isa(t, 'table');
    catch
      cache = false;
    end
  end
  out = cache;
end
