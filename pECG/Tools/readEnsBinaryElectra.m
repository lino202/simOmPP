function [voltage] = readEnsBinaryElectra( name, nNodes )
  
    fid = fopen(name, 'r');
    description = fread(fid,[1 80],'*char');
    part = fread(fid,[1 80],'*char');  % part 80 chars            
    
    if ~isempty(part) && strcmp(part(1:4),'part') && strcmp(description(1:26),'Ensight Model Post Process')

        part_nr      = fread(fid,     1,'*uint32','l' );    % # 1 int
        coordinates  = fread(fid,[1 80],'*char');
        if ~isempty(coordinates) && strcmp(coordinates(1:11),'coordinates')
            voltage  = fread(fid,nNodes,'*float','l' );
        else % code should not arrive here... throw error!
            error(['Unexpected error; coordinates is: ' coordinates ', part_nr is: ' num2str(part_nr)]);
        end

    else % code should not arrive here... throw error!
        error(['Unexpected error; description is: ' description ', part is: ' num2str(part)]);
    end % if
    
    [~] = fread(fid,1);
    if ~feof(fid)
        error(['File: ' name ' did not arrive to the end of line']);
    end
    fclose(fid);

end
