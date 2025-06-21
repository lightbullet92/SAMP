stock SavePosToFile(const filename[], name[], Float:posX, Float:posY, Float:posZ, Float:posRot)
{
    new File:file_ptr = fopen(filename, io_append);
    new str_tmp[256];
    format(str_tmp, sizeof(str_tmp),"%s: %f,%f,%f,%f ;\r\n",name, posX, posY, posZ, posRot);
    fwrite(file_ptr, str_tmp);
    printf("Position %s saved to %s",name,filename);
    fclose(file_ptr);
	return 0;
}
