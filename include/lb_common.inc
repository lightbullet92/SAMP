stock LoadStaticVehiclesFromFile(const filename[])
{
	new File:file_ptr;
	new line[256];
	new var_from_line[64];
	new vehicletype;
	new Float:SpawnX;
	new Float:SpawnY;
	new Float:SpawnZ;
	new Float:SpawnRot;
    new Color1, Color2;
	new index;
	new vehicles_loaded;

	file_ptr = fopen(filename,filemode:io_read);
	if(!file_ptr) return 0;

	vehicles_loaded = 0;

	while(fread(file_ptr,line,256) > 0)
	{
	    index = 0;
  		index = token_by_delim(line,var_from_line,',',index);
  		if(index == (-1)) continue;
  		vehicletype = strval(var_from_line);
   		if(vehicletype < 400 || vehicletype > 611) continue;
  		index = token_by_delim(line,var_from_line,',',index+1);
  		if(index == (-1)) continue;
  		SpawnX = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,',',index+1);
  		if(index == (-1)) continue;
  		SpawnY = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,',',index+1);
  		if(index == (-1)) continue;
  		SpawnZ = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,',',index+1);
  		if(index == (-1)) continue;
  		SpawnRot = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,',',index+1);
  		if(index == (-1)) continue;
  		Color1 = strval(var_from_line);
  		index = token_by_delim(line,var_from_line,';',index+1);
  		Color2 = strval(var_from_line);
		AddStaticVehicleEx(vehicletype,SpawnX,SpawnY,SpawnZ,SpawnRot,Color1,Color2,(30*60));
		vehicles_loaded++;
	}
	fclose(file_ptr);
	printf("Loaded %d vehicles from: %s",vehicles_loaded,filename);
	return vehicles_loaded;
}

stock LoadStaticPickupsFromFile(const filename[])
{
	new File:file_ptr;
	new line[256];
	new var_from_line[64];
	new pickup;
	new type;
	new Float:SpawnX;
	new Float:SpawnY;
	new Float:SpawnZ;
	new index;
	new pickups_loaded;
	file_ptr = fopen(filename,filemode:io_read);
	if(!file_ptr) return 0;
	pickups_loaded = 0;
	while(fread(file_ptr,line,256) > 0)
	{
	    index = 0;
  		index = token_by_delim(line,var_from_line,',',index);
  		if(index == (-1)) continue;
  		pickup = strval(var_from_line);
   		if(pickup < 321 || pickup > 372) continue;
		index = token_by_delim(line,var_from_line,',',index+1);
		if(index == (-1)) continue;
		type = strval(var_from_line);
		if(type < 0 || type > 23) continue;
  		index = token_by_delim(line,var_from_line,',',index+1);
  		if(index == (-1)) continue;
  		SpawnX = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,',',index+1);
  		if(index == (-1)) continue;
  		SpawnY = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,';',index+1);
  		if(index == (-1)) continue;
  		SpawnZ = floatstr(var_from_line);
		AddStaticPickup(pickup,type,SpawnX,SpawnY,SpawnZ);
		pickups_loaded++;
	}
	fclose(file_ptr);
	printf("Loaded %d pickups from: %s",pickups_loaded,filename);
	return pickups_loaded;
}

stock LoadClassesFromFile(const filename[])
{
	new File:file_ptr;
	new line[256];
	new var_from_line[64];
	new classtype;
	new Float:SpawnX;
	new Float:SpawnY;
	new Float:SpawnZ;
	new Float:SpawnRot;
	new index;
	new classes_loaded;
	file_ptr = fopen(filename,filemode:io_read);
	if(!file_ptr) return 0;
	classes_loaded = 0;
	while(fread(file_ptr,line,256) > 0)
	{
	    index = 0;
  		index = token_by_delim(line,var_from_line,',',index);
  		if(index == (-1)) continue;
  		classtype = strval(var_from_line);
   		if(classtype < 0 || classtype > 311) continue;
  		index = token_by_delim(line,var_from_line,',',index+1);
  		if(index == (-1)) continue;
  		SpawnX = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,',',index+1);
  		if(index == (-1)) continue;
  		SpawnY = floatstr(var_from_line);
  		index = token_by_delim(line,var_from_line,',',index+1);
  		if(index == (-1)) continue;
  		SpawnZ = floatstr(var_from_line);
		index = token_by_delim(line,var_from_line,',',index+1);
  		if(index == (-1)) continue;
  		SpawnRot = floatstr(var_from_line);
		AddPlayerClass(classtype,SpawnX,SpawnY,SpawnZ,SpawnRot,0,0,24,300,-1,-1);
		classes_loaded++;
	}
	fclose(file_ptr);
	printf("Loaded %d classes from: %s",classes_loaded,filename);
	return classes_loaded;
}

//----------------------------------------------------------
// Tokenise by a delimiter
// Return string and index of the end determined by the
// provided delimiter in delim

stock token_by_delim(const string[], return_str[], delim, start_index)
{
	new x=0;
	while(string[start_index] != EOS && string[start_index] != delim) {
	    return_str[x] = string[start_index];
	    x++;
	    start_index++;
	}
	return_str[x] = EOS;
	if(string[start_index] == EOS) start_index = (-1);
	return start_index;
}

//----------------------------------------------------------

stock isNumeric(const string[])
{
  new length=strlen(string);
  if (length==0) return false;
  for (new i = 0; i < length; i++)
    {
      if (
            (string[i] > '9' || string[i] < '0' && string[i]!='-' && string[i]!='+') // Not a number,'+' or '-'
             || (string[i]=='-' && i!=0)                                             // A '-' but not at first.
             || (string[i]=='+' && i!=0)                                             // A '+' but not at first.
         ) return false;
    }
  if (length==1 && (string[0]=='-' || string[0]=='+')) return false;
  return true;
}

//----------------------------------------------------------

stock IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

//----------------------------------------------------------
