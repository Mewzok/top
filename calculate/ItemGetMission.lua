--------------------------------------------------------------------------
--									--
--									--
--			ItemGetMission.lua				--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading ItemGetMission.lua" )


---����жϺ���
function CheckMisChaBoat ( role , ChaType )						--��ֻ������
	local Cha_Boat = GetCtrlBoat ( role )
	local ChaIsBoat = 0
	
	if Cha_Boat == nil then
		ChaIsBoat = 1
	else
		ChaIsBoat = 2
	end

	if ChaIsBoat == ChaType then
		return 1
	else
		return 0
	end
end

function CheckChaPos ( role , Cha_x_min , Cha_x_max , Cha_y_min , Cha_y_max , MapName )	--������

	local Cha_Boat = GetCtrlBoat ( role )
	local ChaIsBoat = 0
	if Cha_Boat ~= nil then
		role = Cha_Boat
	end

	local pos_x , pos_y = GetChaPos ( role )
	local map_name = GetChaMapName ( role )


	if MapName ~= -1 then 

		if map_name ~= MapName then
			return 0 
		end 
	end 

	if pos_x < Cha_x_min or pos_x > Cha_x_max then
	
		return 0
	end

	if pos_y < Cha_y_min or pos_y > Cha_y_max then
		return 0
	end

	return 1
end

function CheckChaGuildType ( role , GuildType , CheckType )				--��⹫������
	
	local Cha_GuildID = GetChaGuildID( role )
	

	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		return 0
	end


	if CheckType == 1 then
		if ChaGuildType_Get == GuildType then
			return 1
		else
			return 0
		end
	elseif CheckType == 2 then
		if ChaGuildType_Get == GuildType then
			return 0
		else
			return 1
		end
	else
		return 0
	end

end

function MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	SystemNotice ( role , "MissionMsgCheck")
	local Have_Record	= 0
	local No_Record		= 0
	local Have_Mission	= 0
	local No_Mission	= 0
	
	
	if HasRecordID ~= -1 then
		Have_Record	= HasRecord( role , HasRecordID )
		if Have_Record ~= LUA_TRUE then
			SystemNotice ( role , HasRecordNotice )
			return 0
		end
	end


	if NoRecordID ~= -1 then
		No_Record	= NoRecord( role , NoRecordID )
		if No_Record ~= LUA_TRUE then
			SystemNotice ( role , NoRecordNotice )
			return 0
		end
	end



	if HasMissionID ~= -1 then
		Have_Mission	= HasMission( role , HasMissionID )
		if Have_Mission ~= LUA_TRUE then
			SystemNotice ( role , HasMissionNotice )
			return 0
		end
	end


	if No_MissionID ~= -1 then
		No_Mission	= HasMission( role , No_MissionID )
		if No_Mission == LUA_TRUE then
			SystemNotice ( role , NoMissionNotice )
			return 0
		end
	end
	
	return 1

end

function ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	SystemNotice ( role , "ChaMsgCheck")
	local Is_BoatOrMan = 0
	local At_Pos = 0
	local CheckGuild_Type = 0

	if ChaType ~= -1 then
		Is_BoatOrMan = CheckMisChaBoat( role , ChaType )
		if Is_BoatOrMan == 0 then
			SystemNotice ( role , CheckBoatNotice )
			return 0
		end
	end

	if Need_CheckPos == 1 then
		At_Pos = CheckChaPos ( role , Cha_x_min , Cha_x_max , Cha_y_min , Cha_y_max , MapName )
		if At_Pos == 0 then
			SystemNotice ( role , CheckPosNotice )
			return 0
		end
	end

	if GuildType ~= -1 then
		CheckGuild_Type = CheckChaGuildType ( role , GuildType , CheckType )
		if CheckGuild_Type == 0 then
			SystemNotice ( role , GuildTypeNotice )
			return 0
		end
	end
	
	return 1

end


function ItemUse_LDADYW (role) --[[³�°�������]]--

	local HasRecordID	= 270			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= -1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 4096			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 0			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 4096			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 0			-- �ж�����ID �� Y ������Сֵ
	local MapName		= -1			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	9	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	8	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	10	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	1	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	if ItemID ~= -1 then
		local Item_CanGet = GetChaFreeBagGridNum ( role )
		
		if Item_CanGet < 1 then
			CALCULATE_ITEMGETMISSION_LUA_000002 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000002")
			SystemNotice(role ,CALCULATE_ITEMGETMISSION_LUA_000002)
			UseItemFailed ( role )
			return
		end
	end



	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 
function ItemUse_GLDYS (role) --[[���ϵ�Կ��]]--

	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 15			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 15			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= -1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 4096			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 0			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 4096			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 0			-- �ж�����ID �� Y ������Сֵ
	local MapName		= -1			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000004		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000004		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000004		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000004		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	15	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	15	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	15	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	0	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 



function ItemUse_LDADYS (role) --[[³�°�������]]--

	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 16			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 16			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= -1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 4096			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 0			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 4096			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 0			-- �ж�����ID �� Y ������Сֵ
	local MapName		= -1			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000005		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000005		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000005		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000005		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	16	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	16	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	16	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	0	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 


function ItemUse_YXYSJY (role) --[[����ҩˮ��ҩ]]--

	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 18			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 18			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= -1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 1845			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 1841			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 1719			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 1715			-- �ж�����ID �� Y ������Сֵ
	local MapName		= "magicsea"			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000006		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000006		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000006		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000006		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	18	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	18	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	18	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	0	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 



function ItemUse_RYDKL (role) --[[���������]]--

	local HasRecordID	= 287			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 20			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= 19			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 20			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= 1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 184500			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 184100			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 171900			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 171500			-- �ж�����ID �� Y ������Сֵ
	local MapName		= "magicsea"			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000007		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000007		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000008 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000008")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000008		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000007		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000007		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	20	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	20	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	20	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	1	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	if ItemID ~= -1 then
		local Item_CanGet = GetChaFreeBagGridNum ( role )
		
		if Item_CanGet < 1 then
			CALCULATE_ITEMGETMISSION_LUA_000002 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000002")
			SystemNotice(role ,CALCULATE_ITEMGETMISSION_LUA_000002)
			UseItemFailed ( role )
			return
		end
	end

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 




function ItemUse_SXTCQ (role) --[[ˮ��̽����]]--

	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 29			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= 381			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 29			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= 2			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= 1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 375900			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 375500			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 125000			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 124600			-- �ж�����ID �� Y ������Сֵ
	local MapName		= "magicsea"			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000009		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000009		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000009		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000009		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000010 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000010")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000010		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	29	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	29	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	29	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	1	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	if ItemID ~= -1 then
		local Item_CanGet = GetChaFreeBagGridNum ( role )
		
		if Item_CanGet < 1 then
			CALCULATE_ITEMGETMISSION_LUA_000002 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000002")
			SystemNotice(role ,CALCULATE_ITEMGETMISSION_LUA_000002)
			UseItemFailed ( role )
			return
		end
	end

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 





function ItemUse_RJDYW (role) --[[�ռǵ�����]]--

	local HasRecordID	= 290			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 21			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 21			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= -1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 0			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 0			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 0			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 0			-- �ж�����ID �� Y ������Сֵ
	local MapName		= -1			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000011		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000011		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000011		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000011		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	21	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	21	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	21	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	0	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 






function ItemUse_HL (role) --[[����]]--

	local HasRecordID	= 315			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 22			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 22			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= 2			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= -1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 0			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 0			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 0			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 0			-- �ж�����ID �� Y ������Сֵ
	local MapName		= -1			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000012		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000012		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000012		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000012		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000013 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000013")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000013			--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	22	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	22	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	22	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	0	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 





function ItemUse_WNYDYF (role) --[[����ҩ��ҩ��]]--

	local HasRecordID	= 328			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 30			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 30			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= -1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 0			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 0			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 0			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 0			-- �ж�����ID �� Y ������Сֵ
	local MapName		= -1			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000014		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000014		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000014		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000014		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	30	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	30	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	30	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	0	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 






function ItemUse_LZL (role) --[[��֮��]]--

	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 24			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 24			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= -1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 0			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 0			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 0			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 0			-- �ж�����ID �� Y ������Сֵ
	local MapName		= -1			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000015		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000015		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000015		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000015		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	24	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	24	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	24	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	0	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 

function ItemUse_BLP (role) --[[����ƿ]]--

	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= 369			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= 1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 380200			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 379800			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 55200			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 54800			-- �ж�����ID �� Y ������Сֵ
	local MapName		= "darkblue"			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	-1	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	-1	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	-1	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	4257	--������� ( -1 Ϊ���� )
	local ItemNum		=	1	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	1	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 


function ItemUse_SS (role) --[[ʥˮ]]--

	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 26			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= 370			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 26			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= -1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 0			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 0			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 0			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 0			-- �ж�����ID �� Y ������Сֵ
	local MapName		= -1			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	26	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	26	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	26	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	0	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 



function ItemUse_FHSDX (role) --[[�ۺ�ɫ����]]--

	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 27			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= 362			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 27			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= -1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 0			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 0			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 0			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 0			-- �ж�����ID �� Y ������Сֵ
	local MapName		= -1			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000017		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000017		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000017		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000017		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	27	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	27	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	27	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	0	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 






function ItemUse_WYJ (role) --[[��Զ��]]--

	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 28			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= 375			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 28			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= -1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 0			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 0			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 0			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 0			-- �ж�����ID �� Y ������Сֵ
	local MapName		= -1			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000018		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000018		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000018		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000018		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	28	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	28	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	28	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	0	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 





function ItemUse_LDADYW2 (role) --[[³�°�������2]]--

	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local HasRecordID_1	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 14			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local NoRecordID_1	= -1			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= 273			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local HasMissionID_1	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 14			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local No_MissionID_1	= -1			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )
	local ChaType		= -1			-- �ж��Ƿ�Ϊ�˻�ֻ ( 1 Ϊ �� , 2 Ϊ �� , -1 Ϊ���ж� )
	local Need_CheckPos	= 1			-- �Ƿ��ж����� ( 1 Ϊ �ж� , -1 Ϊ���ж� , ������ж�������͵�ͼ���� 0 )
	local Cha_x_max		= 7900			-- �ж�����ID �� X �������ֵ
	local Cha_x_min		= 7500			-- �ж�����ID �� X ������Сֵ
	local Cha_y_max		= 397300			-- �ж�����ID �� Y �������ֵ
	local Cha_y_min		= 396900			-- �ж�����ID �� Y ������Сֵ
	local MapName		= "garner"			-- �ж��������ڵ�ͼ��
	local GuildType		= -1			-- �ж�����Ĺ������� ( 1 Ϊ���� , 2 Ϊ���� , 0 Ϊû�й��� , -1 Ϊ���ж� )
	local CheckType		= 1			-- �ж����﹫�����͵ķ�ʽ ( 1 Ϊ��ĳ�ֹ������� , 2 Ϊ����ĳ�ֹ������� )


	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000019		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000019		--�ж� NoRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000019		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000019		--�ж� NoMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--�ж� �˻� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--�ж� ���� ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--�ж� �������� ʧ����ʾ

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	14	--������������ (-1 Ϊ���� )
	local GiveMisson_2	=	14	--������������ (-1 Ϊ���� )
	local GiveMisson_0	=	14	--�޹���������� ( -1 Ϊ���� )
	local ItemID		=	-1	--������� ( -1 Ϊ���� )
	local ItemNum		=	0	--�����������
	local Give_Exp		= 	-1	-- Ҫ����ľ��� ( ���Ϊ -1 Ϊ���� )
	local Give_Money	= 	-1	-- Ҫ�����Ǯ ( ���Ϊ -1 Ϊ���� )
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 



function ItemUse_JLYANG(role)   ----����������֪
	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 1820			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 1820			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )



	local HasRecordNotice	 = ""		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--�ж� NoRecord ʧ����ʾ
	local HasMissionNotice	 = ""		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--�ж� NoMission ʧ����ʾ


	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6581	
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
	else
		GiveMission (role,GiveMisson_1)
	end
	
	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )
	
	if DelItem == 0 then
		--UseItemGiveMission ( role )
		UseItemFailed ( role )
	end
end


function ItemUse_PYJSS(role)   -----���������
	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 1824			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 1824			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )



	local HasRecordNotice	 = ""		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--�ж� NoRecord ʧ����ʾ
	local HasMissionNotice	 = ""		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--�ж� NoMission ʧ����ʾ
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6582
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )
	
	if DelItem == 0 then
		--UseItemGiveMission ( role )		
		UseItemFailed ( role )
	end
end


function ItemUse_HDZN(role)   -----����ָ����
	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 1826			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 1826			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )



	local HasRecordNotice	 = ""		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--�ж� NoRecord ʧ����ʾ
	local HasMissionNotice	 = ""		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--�ж� NoMission ʧ����ʾ
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6583
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )
	
	if DelItem == 0 then
		UseItemFailed ( role )		
		--UseItemGiveMission ( role )	
	end
end


function ItemUse_PKZYZ(role)  ---------PKָ��֤
	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 1835			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 1835			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )



	local HasRecordNotice	 = ""		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--�ж� NoRecord ʧ����ʾ
	local HasMissionNotice	 = ""		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--�ж� NoMission ʧ����ʾ
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6584
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )
	
	if DelItem == 0 then
		UseItemFailed ( role )		
		--UseItemGiveMission ( role )	
	end
end



function ItemUse_FLMGZY(role)  ------�����Թ�ָ��
	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 1838			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 1838			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )



	local HasRecordNotice	 = ""		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--�ж� NoRecord ʧ����ʾ
	local HasMissionNotice	 = ""		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--�ж� NoMission ʧ����ʾ
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6585
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )
	
	if DelItem == 0 then
		UseItemFailed ( role )	
		--UseItemGiveMission ( role )			
	end
end


function ItemUse_HDWHZZY(role)  --------��������սָ��
	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 1839			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 1839			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )



	local HasRecordNotice	 = ""		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--�ж� NoRecord ʧ����ʾ
	local HasMissionNotice	 = ""		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--�ж� NoMission ʧ����ʾ
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6586
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem		=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )
	
	if DelItem == 0 then
		UseItemFailed ( role )
	
		--UseItemGiveMission ( role )			
	end
end


function ItemUse_SZZYT(role) ------������ʥսָ��
	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 1841			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 1841			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )



	local HasRecordNotice	 = ""		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--�ж� NoRecord ʧ����ʾ
	local HasMissionNotice	 = ""		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--�ж� NoMission ʧ����ʾ
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6587
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem	=	0	--�Ƿ���ʹ�ú�ɾ������( 1 ɾ, 0 ��ɾ )
	
	if DelItem == 0 then
		UseItemFailed ( role )
	end
end




----------��ͽ��--------------
function ItemUse_TD( role , Item )
	local Cha_Boat = 0
	Cha_Boat = GetCtrlBoat ( role )
	if Cha_Boat ~= nil then 
		CALCULATE_ITEMEFFECT_LUA_000044 = GetResString("CALCULATE_ITEMEFFECT_LUA_000044")
		SystemNotice( role , CALCULATE_ITEMEFFECT_LUA_000044 ) 
		UseItemFailed ( role ) 
		return 
	end
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 2 then
		CALCULATE_ITEMGETMISSION_LUA_000022 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000022")
		SystemNotice(role ,CALCULATE_ITEMGETMISSION_LUA_000022)
		UseItemFailed ( role )
		return
	end		
	local ret = HasMaster(role)
	local lv = GetChaAttr(role, ATTR_LV)
		if ret == LUA_TRUE and lv <= 40 then
		GiveItem( role , 0 , 6049 , 1 , 4 )
		--GiveItem(role , 0 , 6017 , 5 , 4 )
		AddExpAll(role,10000,10000,1)
		elseif ret == LUA_TRUE and lv > 40 then 
			CALCULATE_ITEMGETMISSION_LUA_000023 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000023")
			SystemNotice(role, CALCULATE_ITEMGETMISSION_LUA_000023)
			UseItemFailed ( role)
		elseif ret == LUA_FALSE then
			CALCULATE_ITEMGETMISSION_LUA_000023 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000023")
			SystemNotice(role, CALCULATE_ITEMGETMISSION_LUA_000023)
			UseItemFailed ( role)
		end

end


function ItemUse_STJSHAO (role)   ---������ʦ˵����
	local HasRecordID	= -1			-- �ж��Ƿ����ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1 Ϊ���ж� )
	local NoRecordID	= 1825			-- �ж��Ƿ񲻴���ĳ��¼ ( ��Ҫ�жϵļ�¼ ID , -1Ϊ���ж� )
	local HasMissionID	= -1			-- �ж��Ƿ����ĳ���� ( ��Ҫ�жϵ����� ID , -1 Ϊ���ж� )
	local No_MissionID	= 1825			-- �ж�û�д�ĳ���� ( ��Ҫ�жϵ����� ID ,-1 Ϊ���ж� )

	local HasRecordNotice	 = ""		--�ж� HasRecord ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000024 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000024")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000024		--�ж� NoRecord ʧ����ʾ
	local HasMissionNotice	 = ""		--�ж� HasMission ʧ����ʾ
	CALCULATE_ITEMGETMISSION_LUA_000025 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000025")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000025		--�ж� NoMission ʧ����ʾ
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,6589)
		--UseItemGiveMission ( role )	
		UseItemFailed ( role)
	end
end 
