/*
native KTunCar(vehicleid);
native KaddNos10(vehicleid);
native KaddNos5(vehicleid);
native KaddNos2(vehicleid);
*/
#pragma tabsize 0
//---------------------->KTunCar(vehicleid);<--------------------
stock KTunCar(vehicleid) {
	SetVehicleHealth(vehicleid, 1000);
	new modelid;
	modelid = GetVehicleModel(vehicleid);
switch(modelid){
	case 400:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    AddVehicleComponent(vehicleid,1010);// 1010 ��������� ���� 10�
    AddVehicleComponent(vehicleid,1087);//����������
    AddVehicleComponent(vehicleid,1018);//������
    AddVehicleComponent(vehicleid,1013);//����������������
    AddVehicleComponent(vehicleid,1081);//����� �� Arch
    AddVehicleComponent(vehicleid,1086);//������
	}
    case 401:{//Bravura ID ���� 401
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    AddVehicleComponent(vehicleid,1086);//������
    AddVehicleComponent(vehicleid,1139);//�������(������������ =)
    AddVehicleComponent(vehicleid,1074);//����� ���������
    AddVehicleComponent(vehicleid,1010);//���� 10�
    AddVehicleComponent(vehicleid,1087);//����������
    AddVehicleComponent(vehicleid,1012);//���������������
    AddVehicleComponent(vehicleid,1013);//����������������
    AddVehicleComponent(vehicleid,1042);//������� ���� (�����)
    AddVehicleComponent(vehicleid,1043);//������� ����(������)
    AddVehicleComponent(vehicleid,1018);//������
    AddVehicleComponent(vehicleid,1006);//������ ��������
    AddVehicleComponent(vehicleid,1007);//������ ������
    AddVehicleComponent(vehicleid,1017);
	}
	case 406:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    AddVehicleComponent(vehicleid,1081);//������
	}
	case 444:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    AddVehicleComponent(vehicleid,1081);//������
    AddVehicleComponent(vehicleid,1087);//����������
	}
	case 407:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    AddVehicleComponent(vehicleid,1081);//������
    AddVehicleComponent(vehicleid,1010);//����
	}
	case 578,579,580,582,583,584,585,587,588,589,596,597,
	598,599,600,601,602,604,605,609,568,572,574,402,
	403,404,405,408,409,410,411,412,413,414,415,416,418,
	419,421,422,423,424,426,427,428,429,431,432,433,434,
	436,437,438,439,440,441,442,443,445,451,455,456,
	457,458,459,466,467,470,474,475,477,478,479,480,482,
	483,485,486,489,492,494,495,496,498,499,500,502,503,
	504,505,506,507,508,514,515,516,517,518,524,525,526,
	527,528,529,530,531,532,533,540,541,542,543,566,544,
	545,546,547,549,550,551,552,554,555:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
	AddVehicleComponent(vehicleid,1010);//����
    AddVehicleComponent(vehicleid,1087);//����������
    AddVehicleComponent(vehicleid,1079);}//������
	case 420:{//�����
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
	AddVehicleComponent(vehicleid,1010);//����
    AddVehicleComponent(vehicleid,1087);//����������
    AddVehicleComponent(vehicleid,1081);//������
    AddVehicleComponent(vehicleid,1139);}//������� �������
	case 534:{//�������
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    ChangeVehicleColor(vehicleid,3,3);
    ChangeVehiclePaintjob(vehicleid,2);//��������
    AddVehicleComponent(vehicleid,1180);//������ ��������
    AddVehicleComponent(vehicleid,1185);//������ ������
    AddVehicleComponent(vehicleid,1100);//Remington Misc. Part 1
    AddVehicleComponent(vehicleid,1010);//����
    AddVehicleComponent(vehicleid,1127);//������
    AddVehicleComponent(vehicleid,1101);
    AddVehicleComponent(vehicleid,1122);
    AddVehicleComponent(vehicleid,1087);
	AddVehicleComponent(vehicleid,1080);//������
	}
	case 535:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    ChangeVehiclePaintjob(vehicleid,2);
	AddVehicleComponent(vehicleid,1109);
	AddVehicleComponent(vehicleid,1115);
	AddVehicleComponent(vehicleid,1117);
	AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1087);
    AddVehicleComponent(vehicleid,1114);
    AddVehicleComponent(vehicleid,1081);
    AddVehicleComponent(vehicleid,1119);
    AddVehicleComponent(vehicleid,1121);
	AddVehicleComponent(vehicleid,1080);//������
	}
	case 536:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1183);
    AddVehicleComponent(vehicleid,1181);
    AddVehicleComponent(vehicleid,1107);
    AddVehicleComponent(vehicleid,1104);
    AddVehicleComponent(vehicleid,1108);
    AddVehicleComponent(vehicleid,1087);
    AddVehicleComponent(vehicleid,1081);
	AddVehicleComponent(vehicleid,1080);//������
	}
	case 556,557:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    AddVehicleComponent(vehicleid,1010);
	}
	case 558:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    AddVehicleComponent(vehicleid,1092);
    AddVehicleComponent(vehicleid,1166);
    AddVehicleComponent(vehicleid,1165);
    AddVehicleComponent(vehicleid,1090);
    AddVehicleComponent(vehicleid,1094);
    AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1087);
    AddVehicleComponent(vehicleid,1163);
    AddVehicleComponent(vehicleid,1091);
    ChangeVehiclePaintjob(vehicleid,2);}
    case 559:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    AddVehicleComponent(vehicleid,1070);
    AddVehicleComponent(vehicleid,1066);
    AddVehicleComponent(vehicleid,1072);
	AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1087);
    AddVehicleComponent(vehicleid,1147);
    AddVehicleComponent(vehicleid,1068);
    AddVehicleComponent(vehicleid,1173);
    AddVehicleComponent(vehicleid,1161);
    ChangeVehiclePaintjob(vehicleid,1);}
	case 560:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    AddVehicleComponent(vehicleid,1028);
    AddVehicleComponent(vehicleid,1140);
    AddVehicleComponent(vehicleid,1170);
    AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1087);
    AddVehicleComponent(vehicleid,1139);
    AddVehicleComponent(vehicleid,1033);
    AddVehicleComponent(vehicleid,1031);
    AddVehicleComponent(vehicleid,1030);
    ChangeVehiclePaintjob(vehicleid,1);
	}case 561:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
	AddVehicleComponent(vehicleid,1056);
	AddVehicleComponent(vehicleid,1156);
	AddVehicleComponent(vehicleid,1157);
    AddVehicleComponent(vehicleid,1062);
    AddVehicleComponent(vehicleid,1059);
	AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1087);
    AddVehicleComponent(vehicleid,1146);
    AddVehicleComponent(vehicleid,1061);
    ChangeVehiclePaintjob(vehicleid,2);}
	case 562:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    ChangeVehiclePaintjob(vehicleid,1);
    AddVehicleComponent(vehicleid,1037);
    AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1035);
    AddVehicleComponent(vehicleid,1039);
    AddVehicleComponent(vehicleid,1041);
    AddVehicleComponent(vehicleid,1086);
    AddVehicleComponent(vehicleid,1087);
    AddVehicleComponent(vehicleid,1147);
    AddVehicleComponent(vehicleid,1148);
    AddVehicleComponent(vehicleid,1172);}
	case 565:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    ChangeVehiclePaintjob(vehicleid,2);
    AddVehicleComponent(vehicleid,1046);
    AddVehicleComponent(vehicleid,1151);
    AddVehicleComponent(vehicleid,1152);
    AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1087);
    AddVehicleComponent(vehicleid,1139);
    AddVehicleComponent(vehicleid,1081);
    AddVehicleComponent(vehicleid,1053);
    AddVehicleComponent(vehicleid,1047);
    AddVehicleComponent(vehicleid,1051);}
	case 567:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
	AddVehicleComponent(vehicleid,1188);
	AddVehicleComponent(vehicleid,1186);
	AddVehicleComponent(vehicleid,1102);
	AddVehicleComponent(vehicleid,1133);
    AddVehicleComponent(vehicleid,1018);
    AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1087);
    ChangeVehiclePaintjob(vehicleid,2);
	AddVehicleComponent(vehicleid,1081);}
	case 575:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    ChangeVehiclePaintjob(vehicleid,1);
    AddVehicleComponent(vehicleid,1175);
    AddVehicleComponent(vehicleid,1177);
    AddVehicleComponent(vehicleid,1043);
    AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1081);
    AddVehicleComponent(vehicleid,1042);
    AddVehicleComponent(vehicleid,1099);
    AddVehicleComponent(vehicleid,1087);}
    case 603:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    ChangeVehicleColor(vehicleid,0,3);
   	AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1087);//����������
    AddVehicleComponent(vehicleid,1079);//������
    AddVehicleComponent(vehicleid,1139);//������� �������
    AddVehicleComponent(vehicleid,1019);//������
    AddVehicleComponent(vehicleid,1024);
    AddVehicleComponent(vehicleid,1006);
    }
	case 576:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
    ChangeVehiclePaintjob(vehicleid,2);
    AddVehicleComponent(vehicleid,1191);
    AddVehicleComponent(vehicleid,1193);
    AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1018);
    AddVehicleComponent(vehicleid,1081);
	AddVehicleComponent(vehicleid,1087);
    AddVehicleComponent(vehicleid,1134);
    AddVehicleComponent(vehicleid,1137);}}
 	switch(modelid)
	{case 407,578,579,580,582,583,584,585,587,588,589,596,
	597,400,401,420,534,535,536,556,557,558,559,560,561,
	598,599,600,601,602,604,605,609,568,572,574,402,
	403,404,405,408,409,410,411,412,413,414,415,416,418,
	419,421,422,423,424,426,427,428,429,431,432,433,434,
	436,437,438,439,440,441,442,443,444,445,451,455,456,
	457,458,459,466,467,470,474,475,477,478,479,480,482,
	483,485,486,489,492,494,495,496,498,499,500,502,503,
	504,505,506,507,508,514,515,516,517,518,524,525,526,
	527,528,529,530,531,532,533,540,541,542,543,566,544,
	545,546,547,549,550,551,552,554,555,562,565,567,575,
	576:{
    {
	SetVehicleHealth(vehicleid, 1000);
	new rand = random(126)+0;
	new rand1 = random(126)+0;
	ChangeVehicleColor(vehicleid,rand,rand1);
    }
	AddVehicleComponent(vehicleid,1010);
    AddVehicleComponent(vehicleid,1087);//����������
    AddVehicleComponent(vehicleid,1079);}//������
	}
}
//--------------->KAddNos(vehicleid);<------------------

stock KaddNos10(vehicleid) {
	SetVehicleHealth(vehicleid, 1000);
	new modelid;
	modelid = GetVehicleModel(vehicleid);
	switch(modelid)
	{
		case 407,578,579,580,582,583,584,585,587,588,589,596,
		597,400,401,420,534,535,536,556,557,558,559,560,561,
		598,599,600,601,602,603,604,605,609,568,572,574,402,
		403,404,405,408,409,410,411,412,413,414,415,416,418,
		419,421,422,423,424,426,427,428,429,431,432,433,434,
		436,437,438,439,440,441,442,443,444,445,451,455,456,
		457,458,459,466,467,470,474,475,477,478,479,480,482,
		483,485,486,489,492,494,495,496,498,499,500,502,503,
		504,505,506,507,508,514,515,516,517,518,524,525,526,
		527,528,529,530,531,532,533,540,541,542,543,566,544,
		545,546,547,549,550,551,552,554,555562,565,567,575,
		576:
		{
			AddVehicleComponent(carid,1010);//NOS 10x
		}

	}
}


stock KaddNos5(vehicleid) {
	SetVehicleHealth(vehicleid, 1000);
	new modelid;
	modelid = GetVehicleModel(vehicleid);
	switch(modelid)
	{
		case 407,578,579,580,582,583,584,585,587,588,589,596,
		597,400,401,420,534,535,536,556,557,558,559,560,561,
		598,599,600,601,602,603,604,605,609,568,572,574,402,
		403,404,405,408,409,410,411,412,413,414,415,416,418,
		419,421,422,423,424,426,427,428,429,431,432,433,434,
		436,437,438,439,440,441,442,443,444,445,451,455,456,
		457,458,459,466,467,470,474,475,477,478,479,480,482,
		483,485,486,489,492,494,495,496,498,499,500,502,503,
		504,505,506,507,508,514,515,516,517,518,524,525,526,
		527,528,529,530,531,532,533,540,541,542,543,566,544,
		545,546,547,549,550,551,552,554,555562,565,567,575,
		576:
		{
			AddVehicleComponent(carid,1008);//NOS 5x
		}

	}
}


stock KaddNos2(vehicleid) {
	SetVehicleHealth(vehicleid, 1000);
	new modelid;
	modelid = GetVehicleModel(vehicleid);
	switch(modelid)
	{
		case 407,578,579,580,582,583,584,585,587,588,589,596,
		597,400,401,420,534,535,536,556,557,558,559,560,561,
		598,599,600,601,602,603,604,605,609,568,572,574,402,
		403,404,405,408,409,410,411,412,413,414,415,416,418,
		419,421,422,423,424,426,427,428,429,431,432,433,434,
		436,437,438,439,440,441,442,443,444,445,451,455,456,
		457,458,459,466,467,470,474,475,477,478,479,480,482,
		483,485,486,489,492,494,495,496,498,499,500,502,503,
		504,505,506,507,508,514,515,516,517,518,524,525,526,
		527,528,529,530,531,532,533,540,541,542,543,566,544,
		545,546,547,549,550,551,552,554,555562,565,567,575,
		576:
		{
			AddVehicleComponent(carid,1009);//NOS 5x
		}

	}
}