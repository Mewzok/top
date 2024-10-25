--------------------------------------------------------------------------
--									--
--									--
--				skilleffect.lua				--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading Calculate Files:" )
print( "------------------------------------" )
print( "Loading SkillEffect.lua" )


CALCULATE_SKILLEFFECT_LUA_000001 = GetResString("CALCULATE_SKILLEFFECT_LUA_000001")

dofile(GetResPath("script\\calculate\\exp_and_level.lua"))
dofile(GetResPath("script\\calculate\\JobType.lua"))
dofile(GetResPath("script\\calculate\\AttrType.lua"))
dofile(GetResPath("script\\calculate\\Init_Attr.lua"))
dofile(GetResPath("script\\calculate\\ItemAttrType.lua")) 
dofile(GetResPath("script\\calculate\\functions.lua"))
dofile(GetResPath("script\\calculate\\AttrCalculate.lua")) 
dofile(GetResPath("script\\calculate\\ItemEffect.lua")) 
dofile(GetResPath("script\\calculate\\variable.lua"))
dofile(GetResPath("script\\calculate\\Look.lua"))
dofile(GetResPath("script\\calculate\\forge.lua"))
dofile(GetResPath("script\\calculate\\ItemGetMission.lua"))

CheckDmgChaNameTest = {}
CALCULATE_SKILLEFFECT_LUA_000002 = GetResString("CALCULATE_SKILLEFFECT_LUA_000002")
CheckDmgChaNameTest [0] = CALCULATE_SKILLEFFECT_LUA_000002
CALCULATE_SKILLEFFECT_LUA_000003 = GetResString("CALCULATE_SKILLEFFECT_LUA_000003")
CheckDmgChaNameTest [1] = CALCULATE_SKILLEFFECT_LUA_000003      
CALCULATE_SKILLEFFECT_LUA_000004 = GetResString("CALCULATE_SKILLEFFECT_LUA_000004")
CheckDmgChaNameTest [2] = CALCULATE_SKILLEFFECT_LUA_000004    
CALCULATE_SKILLEFFECT_LUA_000005 = GetResString("CALCULATE_SKILLEFFECT_LUA_000005")
CheckDmgChaNameTest [3] = CALCULATE_SKILLEFFECT_LUA_000005      
CALCULATE_SKILLEFFECT_LUA_000006 = GetResString("CALCULATE_SKILLEFFECT_LUA_000006")
CheckDmgChaNameTest [4] = CALCULATE_SKILLEFFECT_LUA_000006

BOSSXYSJ = {}
BOSSXYSJ[979] = 1
BOSSXYSJ[980] = 12
BOSSXYSJ[981] = 6
BOSSXYSJ[982] = 4
BOSSXYSJ[983] = 12
BOSSXYSJ[984] = 16
BOSSXYSJ[985] = 16
BOSSXYSJ[986] = 12
BOSSXYSJ[987] = 4
BOSSXYSJ[988] = 4

BOSSSJSJ = {}
BOSSSJSJ[979] = 8
BOSSSJSJ[980] = 1
BOSSSJSJ[981] = 6
BOSSSJSJ[982] = 4
BOSSSJSJ[983] = 12
BOSSSJSJ[984] = 16
BOSSSJSJ[985] = 16
BOSSSJSJ[986] = 12
BOSSSJSJ[987] = 4
BOSSSJSJ[988] = 4

BOSSTJSJ = {}
BOSSTJSJ[979] = 8
BOSSTJSJ[980] = 1
BOSSTJSJ[981] = 6
BOSSTJSJ[982] = 4
BOSSTJSJ[983] = 12
BOSSTJSJ[984] = 16
BOSSTJSJ[985] = 16
BOSSTJSJ[986] = 12
BOSSTJSJ[987] = 4
BOSSTJSJ[988] = 4

BOSSXZSJ = {}
BOSSXZSJ[979] = 12
BOSSXZSJ[980] = 12
BOSSXZSJ[981] = 16
BOSSXZSJ[982] = 16
BOSSXZSJ[983] = 12
BOSSXZSJ[984] = 4
BOSSXZSJ[985] = 1
BOSSXZSJ[986] = 6
BOSSXZSJ[987] = 4
BOSSXZSJ[988] = 4

BOSSAYSJ = {}
BOSSAYSJ[979] = 12
BOSSAYSJ[980] = 12
BOSSAYSJ[981] = 16
BOSSAYSJ[982] = 16
BOSSAYSJ[983] = 12
BOSSAYSJ[984] = 4
BOSSAYSJ[985] = 1
BOSSAYSJ[986] = 6
BOSSAYSJ[987] = 4
BOSSAYSJ[988] = 4

function SkillLog(atk,def,dmg,skname,sklv)
	local atkName = GetChaDefaultName(atk)
	local defName = GetChaDefaultName(def)
	local atkBA = {}
	local defBA = {}
	local i = 1 
	for i = 1,22,1 do 
		atkBA[i]= GetChaAttr( atk ,ATTR_COUNT_BASE1+i-1)
		defBA[i] = GetChaAttr( def ,ATTR_COUNT_BASE1+i-1)
	end
	LG("skillLOg",atkName,skname,sklv,atkBA[1],atkBA[2],atkBA[3],atkBA[4],atkBA[5],atkBA[7],atkBA[8],atkBA[9],atkBA[10],atkBA[11],atkBA[12],atkBA[13],atkBA[15],atkBA[16],atkBA[17],atkBA[18],atkBA[20],atkBA[22],defName,dmg,defBA[11],defBA[22])
end
function Check_Baoliao(ATKER, DEFER, ... ) --[[�ж��Ƿ���,���빥���ߵȼ����ܻ��ߵȼ��������߱����ʡ��ܻ��߱�����]]--
    local diaoliao_count = arg.n 
	--LuaPrint("Enter function Check_Baoliao(Atker,Defer,mf_atker,mf_defer) --[[�ж��Ƿ���]]--".."\n" ) 
	--LG("����", "Enter function Check_Baoliao(Atker,Defer,mf_atker,mf_defer) --[[�ж��Ƿ���]]--","\n" ) 
	Atker = TurnToCha ( ATKER ) 
	Defer = TurnToCha ( DEFER ) 
	local lv_atker = Lv(Atker)
	local lv_defer = Lv(Defer)
	local count = 0
	local crt_baoliao1 = 0.1 
	local crt_baoliao2 = 0.01 
	local crt_baoliao3 = 0.00001
	local MF_RAID_STATE = 1
	local StateLv = GetChaStateLv ( ATKER , STATE_SBBLGZ )
	item = {} 
	local bsmf=( 1) * ( 1 ) 
	if IsPlayer(Defer) == 1 then		--______________________________________pk���ڵ���֤��_____________________________
	--LG("����","is PVP")	
		if IsInGymkhana(Defer) == 1 then 
		--LG("����","is in PK")
			count = 1 
			if lv_defer - lv_atker >= 5 then
				item[count] = 1
			elseif lv_defer - lv_atker <= (- 5)  then
				item[count] = 3
			else
				item[count] = 2
			end
			--LuaPrint("Out function Check_Baoliao(lv_atker,lv_defer,mf_atker,mf_defer) --[[�ж��Ƿ���]]--") 
			--LG("����" , "function Check_Baoliao : " , "count = " , count , "item[1] =" ,item[1] , "item[2] = " , item[2], "item[3] = " , item[3] ,  "item[4] = " ,item[4] , "item[5] = " , item[5] , "item[6] = " ,item[6] , "item[7] = " ,item[7], "item[8] = " ,item[8], "item[9] = " ,item[9], "item[10] = " ,item[10]) 
			SetItemFall ( count , item[1] , item[2] , item[3] , item[4] , item[5] , item[6], item[7] ,item[8],item[9],item[10] )
		end 
	else	
--______________________________________�����������______________________________

		--LG("����", "���ϼ��� = ", bsmf ,"\n") 
		if diaoliao_count <= 0 or diaoliao_count > 10 then 
			--LG("baoliao_err", "function Check_Baoliao : " , " ���ϸ�������10����diaoliao_count = " , diaoliao_count ) 
			return 
		end 
		
		if StateLv >= 0 and StateLv <= 10 then

			MF_RAID_STATE = BLStateBS[StateLv]
			
		end
		for i = 1 , diaoliao_count , 1 do 
			if arg[i] >= 100 then 
				mf = math.min ( 1, 100 / arg[i] * bsmf ) * MF_RAID * MF_RAID_STATE
				
				--������ϵ��
				local retExpState = GetExpState(ATKER)
--				Notice("��Ϸ�����ʵķ�����ϵ��Ϊ"..retExpState )
				mf =	mf *GetExpState(ATKER) / 100
				
				a = Percentage_Random(mf) 
				if a == 1 then 
					count = count + 1 
					item[count] = i 
				end 
			else 
				--LG("baoliao_err", "function Check_Baoliao : " , " ���ϸ��ʴ��� ", "��", i , "�ֵ��ϸ��� = " , arg[i] )  
			end 
		end 
		--LG("����" , "function Check_Baoliao : " , "count = " , count , "item[1] =" ,item[1] , "item[2] = " , item[2], "item[3] = " , item[3] ,  "item[4] = " ,item[4] , "item[5] = " , item[5] , "item[6] = " ,item[6] , "item[7] = " ,item[7], "item[8] = " ,item[8], "item[9] = " ,item[9], "item[10] = " ,item[10]) 
		SetItemFall ( count , item[1] , item[2] , item[3] , item[4] , item[5] , item[6], item[7] ,item[8],item[9],item[10] )  
	end
end 




function Check_SpawnResource ( ATKER, DEFER , lv_skill , diaoliao_count , ...) --[[�ж��Ƿ񱩿�,���ܵȼ�,�������]]--
	--LuaPrint("Enter function Check_SpawnResource  --[[�ж��Ƿ񱩿�]]--".."\n" ) 
	item = {} 
	local count = 0 
	local bsmf=1  
	--LG("����", "������ = ", bsmf ,"\n") 
	if diaoliao_count <= 0 or diaoliao_count > 10 then 
		--LG("����_err", "function Check_���� : " , " ���ϸ�������6����diaoliao_count = " , diaoliao_count ) 
		return 
	end 
	
--	local SpItemAdd = 1
--	local Take_Item = 0
	local ResourceGet_RAID = 1
	local ResourceItemUse_Check = 0
	ResourceItemUse_Check = CheckCha_ResourceItemUse ( ATKER )
	
	if ResourceItemUse_Check == 1 then
		ResourceGet_RAID = 2
	end

	local UnNormal_ResourceID_Num = 1
	local UnNormal_ResourceID = {}
	UnNormal_ResourceID[0] = 777
	UnNormal_ResourceID[1] = 778

	local Resource_ID = GetChaTypeID( DEFER )

	local Un_C = 0
	
	for Un_C = 0 , UnNormal_ResourceID_Num , 1 do
		if Resource_ID == UnNormal_ResourceID[Un_C] then				----������Դ�ø߼���ľ���Ϳ����Ч
			ResourceGet_RAID = 1
		end
	end

	local Tree_ID = GetChaTypeID( DEFER )
	local Tree_hp = Hp( DEFER )
	local i = 0
	
	for Un_C = 0 , UnNormal_ResourceID_Num , 1 do						----������Դ���ܵȼ���Ч
		if Tree_ID == UnNormal_ResourceID[Un_C] then
				lv_skill = 0
		end
	end

	for i = 1 , diaoliao_count , 1 do
		if arg[i] >= 100 then 
			mf = math.min ( 1, 100 / arg[i] * bsmf * (1 + lv_skill * 0.1 ) ) * ResourceGet_RAID * Resource_RAID_ADJUST
			a = Percentage_Random(mf) 
			if a == 1 then 
				count = count + 1 
				item[count] = i 
			end 
		else 
			--LG("����_err", "function Check_SpawnResource : " , " ���ϸ��ʴ��� ", "��", i , "�ֵ��ϸ��� = " , arg[i] )  
		end 
	end 
	--LuaPrint("Out function Check_SpawnResource(lv_atker,lv_defer,mf_atker,mf_defer) --[[�ж��Ƿ񱩿�]]--") 
	--LG("����" , "function Check_SpawnResource : " , "count = " , count , "item[1] =" ,item[1] , "item[2] = " , item[2], "item[3] = " , item[3] ,  "item[4] = " ,item[4] , "item[5] = " , item[5] , "item[6] = " ,item[6] , "item[7] = " ,item[7], "item[8] = " ,item[8], "item[9] = " ,item[9], "item[10] = " ,item[10]) 
	if count >= 1 then 
		item[1] = item[count]  
		count = 1 
	end 
	SetItemFall ( count , item[1] , item[2] , item[3] , item[4] , item[5] , item[6], item[7] ,item[8],item[9],item[10] )  
end 

function CheckCha_ResourceItemUse ( role )
	local Item_Use = GetChaItem ( role , 1 , 9 )
	local ItemID_Use = GetItemID ( Item_Use )
	
	if ItemID_Use == 207 or ItemID_Use == 208 then
		return 1
	end
	return 0
end



function SetSus( role , sus ) 
	if sus == 0 then 
		SkillMiss( role )  
	elseif sus==2 then 
		SkillCrt( role )  
	end 
end 


function Skill_Melee_Begin ( role , sklv ) 
end 

function Skill_Melee_End ( ATKER , DEFER , sklv )						--[[����"������ͨ����"���˺����㣨����miss�ͱ������㣩]]--
--		Check_State ( ATKER , DEFER ) 
		if ValidCha(ATKER) == 0 then 
			CALCULATE_SKILLEFFECT_LUA_000007 = GetResString("CALCULATE_SKILLEFFECT_LUA_000007")
			LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000007 ) 
			return 
		end 
		if ValidCha(DEFER) == 0 then 
			CALCULATE_SKILLEFFECT_LUA_000008 = GetResString("CALCULATE_SKILLEFFECT_LUA_000008")
			LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000008 ) 
			return 
		end 
		local ChaName_ATKER = GetChaDefaultName ( ATKER )
		local ChaName_DEFER = GetChaDefaultName ( DEFER )

		

		dmg = Atk_Dmg( ATKER, DEFER )					--[[������ͨ���������������˺�]]--
		sus,dmgsa = Check_MisorCrt( ATKER , DEFER )			--[[�Ƿ�miss��crt]]--
		SetSus( DEFER , sus )								--���ñ�����miss 
--		if atk_statecheck[STATE_ZMYJ] >= 1 then 
--			dmgsa = Check_Zmyj ( ATKER , dmgsa )		--�жϱ����˺�����
--		end 
		if dmgsa == 1 then
			local Elf_Item = CheckHaveElf ( ATKER )
			if Elf_Item ~= 0 then
				local Num = GetItemForgeParam ( Elf_Item , 1 )
				local CheckElfSkill = CheckElfHaveSkill ( Num , 0 , 2 )
				local ElfCrt = 0
				if CheckElfSkill == 2 then
					ElfCrt = ElfSKill_ElfCrt ( ATKER , Elf_Item , Num )
					if ElfCrt == 1 then
						CALCULATE_SKILLEFFECT_LUA_000009 = GetResString("CALCULATE_SKILLEFFECT_LUA_000009")
						SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000009 )
						CALCULATE_SKILLEFFECT_LUA_000010 = GetResString("CALCULATE_SKILLEFFECT_LUA_000010")
						SystemNotice ( DEFER , CALCULATE_SKILLEFFECT_LUA_000010 )
						dmgsa = 2
						SetSus( DEFER , sus )
					end
				end
			end
		end
		hpdmg = math.floor( dmg*dmgsa )				--[[ȡ�����˺�����С�˺��е����ֵ,��miss�ͱ����˺�]]--
--		local mars = 0
--		for mars = 0 , 4 , 1 do
--			if ChaName_DEFER == CheckDmgChaNameTest [mars] then
--				local Atker_aspd = Aspd ( ATKER )
--				local Atker_mxatk = Mxatk ( ATKER )
--				local Atker_mnatk = Mnatk ( ATKER )
--				LG ( "whydie" , ChaName_DEFER.."��"..ChaName_ATKER.."����".."�˺�ֵΪ"..hpdmg )
--				LG ( "whydie" , ChaName_ATKER.."�����ٶ�"..Atker_aspd.."��󹥻�"..Atker_mxatk.."��С����"..Atker_mnatk )
--			end
--		end
		Hp_Endure_Dmg( DEFER , hpdmg )				--[[�����ܻ��߿�Ѫ]]--
--		a = Check_Zjft ( )							--�ж��ؼ׷���

--		if a > 0 then 
--			Hp_Endure_Dmg ( ATKER , hpdmg * a  )				--�����˺�
--		end 
--		if def_statecheck[STATE_BSHD] >= 1 then			--�жϱ�˪����
--			statetime = Check_Bshd ( def_statecheck[STATE_BSHD]) 
--			AddState( ATKER , DEFER , STATE_BD , def_statecheck , statetime ) 
--		end 
		Take_Atk_ItemURE ( ATKER )						--��ȡ�����������;�
		Take_Def_ItemURE ( DEFER )						--��ȡ�ܻ��߷����;�

		local Check_Nianshou = CheckItem_Nianshou ( ATKER )
		local Check_ZHONGSHEN = CheckItem_ZHONGSHEN ( ATKER )
		if Check_Nianshou == 1 then
			local P_R = 0.1
			local job = GetChaAttr( ATKER , ATTR_JOB )
			if job == 5 then
				P_R = 0.03
			end
			local Percentage = Percentage_Random ( P_R )
			if Percentage == 1 then
				AddState ( ATKER , DEFER , STATE_XY , 1 , 1 )
				CALCULATE_SKILLEFFECT_LUA_000011 = GetResString("CALCULATE_SKILLEFFECT_LUA_000011")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000011)
			end
		end
		if Check_ZHONGSHEN == 1 then
			local P_R = 0.1
			local job = GetChaAttr( ATKER , ATTR_JOB )
			if job == 5 then
				P_R = 0.03
			end
			local Percentage = Percentage_Random ( P_R )
			if Percentage == 1 then
				AddState ( ATKER , DEFER , STATE_XY , 1 , 1 )
				CALCULATE_SKILLEFFECT_LUA_000012 = GetResString("CALCULATE_SKILLEFFECT_LUA_000012")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000012)
			end
		end
		
		Check_Ys_Rem ( ATKER , DEFER)						--�ж��Ƿ�����
	-----������״̬
	GivePetState(ATKER , DEFER )
		
 end 

 function Skill_lackart_End ( ATKER , DEFER , sklv )						--[[����"������ͨ����"���˺����㣨����miss�ͱ������㣩]]--
		if ValidCha(ATKER) == 0 then 
			CALCULATE_SKILLEFFECT_LUA_000007 = GetResString("CALCULATE_SKILLEFFECT_LUA_000007")
			LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000007 ) 
			return 
		end 
		if ValidCha(DEFER) == 0 then 
			CALCULATE_SKILLEFFECT_LUA_000008 = GetResString("CALCULATE_SKILLEFFECT_LUA_000008")
			LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000008 ) 
			return 
		end 
		local ChaName_ATKER = GetChaDefaultName ( ATKER )
		local ChaName_DEFER = GetChaDefaultName ( DEFER )
		dmg = Atk_Dmg( ATKER, DEFER )					--[[������ͨ���������������˺�]]--
		Hp_Endure_Dmg( DEFER , dmg )				--[[�����ܻ��߿�Ѫ]]--
		Take_Atk_ItemURE ( ATKER )						--��ȡ�����������;�
		Take_Def_ItemURE ( DEFER )						--��ȡ�ܻ��߷����;�

		local Check_Nianshou = CheckItem_Nianshou ( ATKER )
		local Check_ZHONGSHEN = CheckItem_ZHONGSHEN ( ATKER )
		if Check_Nianshou == 1 then
			local P_R = 0.1
			local job = GetChaAttr( ATKER , ATTR_JOB )
			if job == 5 then
				P_R = 0.03
			end
			local Percentage = Percentage_Random ( P_R )
			if Percentage == 1 then
				AddState ( ATKER , DEFER , STATE_XY , 1 , 1 )
				CALCULATE_SKILLEFFECT_LUA_000011 = GetResString("CALCULATE_SKILLEFFECT_LUA_000011")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000011)
			end
		end
		if Check_ZHONGSHEN == 1 then
			local P_R = 0.1
			local job = GetChaAttr( ATKER , ATTR_JOB )
			if job == 5 then
				P_R = 0.03
			end
			local Percentage = Percentage_Random ( P_R )
			if Percentage == 1 then
				AddState ( ATKER , DEFER , STATE_XY , 1 , 1 )
				CALCULATE_SKILLEFFECT_LUA_000012 = GetResString("CALCULATE_SKILLEFFECT_LUA_000012")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000012)
			end
		end
		
		Check_Ys_Rem ( ATKER , DEFER)						--�ж��Ƿ�����
	-----������״̬
	GivePetState(ATKER , DEFER )
		
 end 

function Skill_Range_Begin ( role , sklv ) 
end 

function Skill_Range_End ( ATKER , DEFER , sklv )					--[[����"Զ����ͨ����"���˺����㣨����miss�ͱ������㣩]]--
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000013 = GetResString("CALCULATE_SKILLEFFECT_LUA_000013")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000013 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000014 = GetResString("CALCULATE_SKILLEFFECT_LUA_000014")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000014 ) 
		return 
	end 
		local ChaName_ATKER = GetChaDefaultName ( ATKER )
		local ChaName_DEFER = GetChaDefaultName ( DEFER )

		dmg = Atk_Dmg( ATKER , DEFER )					--[[������ͨ���������������˺�]]--
		sus,dmgsa = Check_MisorCrt( ATKER, DEFER )		--[[�Ƿ�miss��crt]]--
		SetSus(DEFER , sus)							--���ñ�����miss 
--		dmgsa = Check_Zmyj ( ATKER , dmgsa )		--�жϱ����˺�����
		if dmgsa == 1 then
			local Elf_Item = CheckHaveElf ( ATKER )
			if Elf_Item ~= 0 then
				local Num = GetItemForgeParam ( Elf_Item , 1 )
				local CheckElfSkill = CheckElfHaveSkill ( Num , 0 , 2 )
				local ElfCrt = 0
				if CheckElfSkill == 2 then
					ElfCrt = ElfSKill_ElfCrt ( ATKER , Elf_Item , Num )
					if ElfCrt == 1 then
						CALCULATE_SKILLEFFECT_LUA_000009 = GetResString("CALCULATE_SKILLEFFECT_LUA_000009")
						SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000009 )
						CALCULATE_SKILLEFFECT_LUA_000010 = GetResString("CALCULATE_SKILLEFFECT_LUA_000010")
						SystemNotice ( DEFER , CALCULATE_SKILLEFFECT_LUA_000010 )
						dmgsa = 2
						SetSus( DEFER , sus )
					end
				end
			end
		end
		
		hpdmg = math.floor( dmg*dmgsa ) 			--[[ȡ�����˺�����С�˺��е����ֵ,��miss�ͱ����˺�]]--
--		local mars = 0
--		for mars = 0 , 4 , 1 do
--			if ChaName_DEFER == CheckDmgChaNameTest [mars] then
--				local Atker_aspd = Aspd ( ATKER )
--				local Atker_mxatk = Mxatk ( ATKER )
--				local Atker_mnatk = Mnatk ( ATKER )
--				LG ( "whydie" , ChaName_DEFER.."��"..ChaName_ATKER.."����".."�˺�ֵΪ"..hpdmg )
--				LG ( "whydie" , ChaName_ATKER.."�����ٶ�"..Atker_aspd.."��󹥻�"..Atker_mxatk.."��С����"..Atker_mnatk )
--			end
--		end
		Hp_Endure_Dmg( DEFER , hpdmg )					--[[�����ܻ��߿�Ѫ]]--
		
		Take_Atk_ItemURE ( ATKER )						--��ȡ�����������;�
		Take_Def_ItemURE ( DEFER )						--��ȡ�ܻ��߷����;�

		local Check_Nianshou = CheckItem_Nianshou ( ATKER )
		local Check_ZHONGSHEN = CheckItem_ZHONGSHEN ( ATKER )
		if Check_Nianshou == 1 then
			local Percentage = Percentage_Random ( 0.1 )
			if Percentage == 1 then
				AddState ( ATKER , DEFER , STATE_XY , 1 , 1 )
				CALCULATE_SKILLEFFECT_LUA_000011 = GetResString("CALCULATE_SKILLEFFECT_LUA_000011")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000011)
			end
		end
		if Check_ZHONGSHEN == 1 then
			local Percentage = Percentage_Random ( 0.1 )
			if Percentage == 1 then
				AddState ( ATKER , DEFER , STATE_XY , 1 , 1 )
				CALCULATE_SKILLEFFECT_LUA_000012 = GetResString("CALCULATE_SKILLEFFECT_LUA_000012")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000012)
			end
		end

		Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
	----������״̬
	GivePetState(ATKER , DEFER )	
end 


function Mis_or_Crt(a,b)							--[[����miss��crt��]]-- 
	local m=Percentage_Random(a)					--[[����Ƿ�miss]]--
	local n=Percentage_Random(b)					--[[����Ƿ񱩻�]]--
	local rom,dmgsa=1,1  
	if m==1 then 
		rom=0 dmgsa=0 
	elseif n==1 then 
		rom=2 dmgsa=2 
	end										--[[�ж��Ƿ�miss�򱩻�]]--
	return rom,dmgsa 
end 

function Phy_Dmg (atk, def, resist )					--[[������������]]--
--Notice("Phy_Dmg1")
	local phy_atk = atk 
	local phy_def = def 
	local phy_resist = resist 
	
--	LuaPrint ( " ���������� "..phy_atk.." ��������= "..phy_def.." �����ֿ�= "..phy_resist ) 
--	LuaPrint (\n) 
--	LG ( " �˺�" , "�������� = ", phy_atk, " �������� = " , phy_def, " �����ֿ� = " , phy_resist, "\n" ) 
	dmg = math.floor( phy_atk  * (1 - math.min (0.85 , phy_resist/100 )  ) - phy_def ) 
	
	return dmg 
end 

function Phy_Dmg_A (a,b,atk, def, resist )					--[[������������]]--
--Notice("Phy_Dmg1")
	local phy_atk = atk 
	local phy_def = def 
	local phy_resist = resist 
	local map_name_ATKER = GetChaMapName ( a )
	local map_name_DEFER = GetChaMapName ( b )
	local Can_Pk_Garner2 = Is_NormalMonster (b)
		
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then
			dmg = math.floor( phy_atk  - phy_def ) * (1 - math.min (0.85 , phy_resist/100 )  ) 
			return dmg 
			end
		end
--	LuaPrint ( " ���������� "..phy_atk.." ��������= "..phy_def.." �����ֿ�= "..phy_resist ) 
--	LuaPrint (\n) 
--	LG ( " �˺�" , "�������� = ", phy_atk, " �������� = " , phy_def, " �����ֿ� = " , phy_resist, "\n" ) 
	dmg = math.floor( phy_atk  * (1 - math.min (0.85 , phy_resist/100 )  ) - phy_def ) 
	
	return dmg 
end 

function Pow_Dmg (atk, def, resist ) --[[��ҩ��������]]--
	local pow_atk = atk 
	local pow_def = def 
	local pow_resist = resist 
--	LuaPrint ( " ��ҩ������ "..pow_atk.." ��������= "..phy_def.." �����ֿ�= "..phy_resist ) 
--	LuaPrint (\n) 
--	LG ( " �˺�" , "��ҩ���� = ", phy_atk, " �������� = " , phy_def, " �����ֿ� = " , phy_resist, "\n" ) 
--	local statelv_rdgj = GetChaStateLv( ATKER, STATE_RDGJ ) 
--	local pow_resist = pow_resist * ( 1 - statelv_rdgj * 0.05 ) 
	dmg = math.floor( pow_atk * (1 - math.min(0.85 ,  pow_resist/100 )  ) - pow_def ) 
	return dmg 
end 


--function MAGIC_Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--
----	Check_State ( a , b ) 
--	--LuaPrint("Enter function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--".."\n") 
--	--LG("Atk_Dmg","Enter function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--", "\n" ) 
--	local atk_mnatk = Mnatk(a) 
--	local atk_mxatk = Mxatk(a) 
----	if atk_statecheck[STATE_SMYB] >= 1 then 
----		atk_mnatk,atk_mxatk = Check_Smyb ( a ) 
----	end 
--	local defer_def = Def(b)  
--	local defer_resist = Resist(b)  
--	local atker_lv = Lv( a ) 
--	local defer_lv = Lv( b ) 
--	local lv_dis = atker_lv - defer_lv 
--	local lv_eff = 1 
--	if math.abs (lv_dis) >= 1 then 
--		lv_eff =math.min (  math.max ( 0.5 , 1 + 0.025 * lv_dis ) , 1.5 )  
--	end 
--		
--	
--	--LG("Atk_Dmg", "atk_mnatk = ", atk_mnatk, "atk_mxatk =", atk_mxatk, "defer_def = ", defer_def,  "atker_lv = ", atker_lv, "\n" ) 
--	local atk = math.random( atk_mnatk , atk_mxatk ) 
--	local dmg = Phy_Dmg ( atk, defer_def , defer_resist )  --[[���������˺�ֵ]]--
--	local mndmg = math.floor(  Lv(a) * 0.25 + Mnatk(a) * 0 ) + 1 --[[������С�˺�ֵ]]--
--	dmg =math.max(  lv_eff * dmg , mndmg ) 
--	--LG("Atk_Dmg", "�����˺�dmg = ", dmg, "��С�˺�mndmg = ", mndmg, "\n" ) 
--	--LG("Atk_Dmg","End function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--".."\n" ) 
--	--LuaPrint("Out function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--") 
--	return dmg 
--end 

function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--
--	Check_State ( a , b ) 
	--LuaPrint("Enter function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--".."\n") 
	--LG("Atk_Dmg","Enter function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--", "\n" ) 
	local atk_mnatk = Mnatk(a) 
	local atk_mxatk = Mxatk(a) 
--	if atk_statecheck[STATE_SMYB] >= 1 then 
--		atk_mnatk,atk_mxatk = Check_Smyb ( a ) 
--	end 
	local defer_def = Def(b)  
	local defer_resist = Resist(b)  
	local atker_lv = Lv ( TurnToCha(a) ) 
	local defer_lv = Lv ( TurnToCha(b) ) 
	local lv_dis = atker_lv - defer_lv 
	local lv_eff = 1 
	if math.abs (lv_dis) >= 1 then 
		lv_eff =math.min (  math.max ( 0.8 , 1 + 0.025 * lv_dis ) , 1.2 )  
	end 
		
	
	--LG("Atk_Dmg", "atk_mnatk = ", atk_mnatk, "atk_mxatk =", atk_mxatk, "defer_def = ", defer_def,  "atker_lv = ", atker_lv, "\n" ) 
	local atk = math.random( atk_mnatk , atk_mxatk ) 
	local dmg = Phy_Dmg ( atk, defer_def , defer_resist )  --[[���������˺�ֵ]]--
	local map_name_ATKER = GetChaMapName ( a )
	local map_name_DEFER = GetChaMapName ( b )
	local Can_Pk_Garner2 = Is_NormalMonster (b)
		
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
	--	Notice("22")
			
			if Can_Pk_Garner2 == 0 then
		--	Notice("Can_Pk_Garner2")
			dmg = Phy_Dmg_A ( a,b,atk, defer_def , defer_resist )
			end
		end
	--local dmg = Phy_Dmg ( a,b,atk, defer_def , defer_resist )
	local mndmg = math.floor(  Lv( TurnToCha(a) ) * 0.25 + Mnatk(a) * 0 ) + 1 --[[������С�˺�ֵ]]--
	dmg =math.max(  lv_eff * dmg, mndmg ) 
	--LG("Atk_Dmg", "�����˺�dmg = ", dmg, "��С�˺�mndmg = ", mndmg, "\n" ) 
	--LG("Atk_Dmg","End function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--".."\n" ) 
	--LuaPrint("Out function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--")
	local ZSExp = GetChaAttr( a , ATTR_CSAILEXP )
	if ZSExp > 0 and ZSExp < 100 then
		dmg = dmg * 1.055
	end
	if ZSExp >= 100 and ZSExp < 12100 then
		dmg = dmg * ( 1.05 + math.floor( math.pow( (ZSExp / 100) , 0.5 )) * 0.005)
	end
	return dmg 
end 

function Fire_Dmg(a,b) --[[�����ҩ�����Ļ��������˺�]]--
	--LuaPrint("Enter function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--".."\n") 
	--LG("Atk_Dmg","Enter function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--".."\n" ) 
	local defer_def = Def(b)  
	local defer_resist = Resist(b)  
	local atker_lv = Lv ( TurnToCha(a) ) 
	local defer_lv = Lv ( TurnToCha(b) ) 
	local lv_dis = atker_lv - defer_lv 
	local lv_eff = 1 
	if math.abs (lv_dis) >= 5 then 
		lv_eff =math.min (  math.max ( 0.8 , 1 + 0.025 * lv_dis ) , 1.2 )  
	end 
--	LG("Fire_Dmg", "atk_mnatk = ", atk_mnatk, "atk_mxatk =", atk_mxatk, "defer_def = ", defer_def,  "atker_lv = ", atker_lv, "\n" )
	local atk = math.random( Mnatk(a), Mxatk(a) ) 
	local dmg = Pow_Dmg ( atk, defer_def , defer_resist )  --[[���������˺�ֵ]]--
	local mndmg = math.floor(  Lv(TurnToCha(a) ) * 0.25 + Mnatk(a) * 0 ) + 1 --[[������С�˺�ֵ]]--
	dmg = math.max( dmg, mndmg ) 
--	LG("Fire_Dmg", "�����˺�dmg = ", dmg, "��С�˺�mndmg = ", mndmg, "\n" ) 
--	LG("Fire_Dmg","End function Fire_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--".."\n" ) 
	--LuaPrint("Out function Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--")
	local ZSExp = GetChaAttr( a , ATTR_CSAILEXP )
	if ZSExp > 0 and ZSExp < 100 then
		dmg = dmg * 1.055
	end
	if ZSExp >= 100 and ZSExp < 12100 then
		dmg = dmg * ( 1.05 + math.floor( math.pow( (ZSExp / 100) , 0.5 )) * 0.005)
	end
	return dmg 
end 

function Check_MisorCrt(a,b) --[[�ж��Ƿ�miss��crt]]--
	--LuaPrint("Enter function Check_MisorCrt(a,b) --[[�ж��Ƿ�miss��crt]]--") 
	--LG("Mis or Crt" , "Enter function Check_MisorCrt(a,b) --[[�ж��Ƿ�miss��crt]]--", "\n") 
	local def_flee = Flee(b) 
	local atk_hit = Hit(a) 
	--LG("Mis or Crt" , "����flee = ", atk_flee , "����hit = ", atk_hit, "\n") 
	local def_lv = Lv( TurnToCha(b) ) 
	local atk_lv = Lv( TurnToCha(a) ) 
	local lv_dis = atk_lv - def_lv 
	local lv_eff = 0 
	if math.abs (lv_dis) >= 1 then 
		lv_eff =math.min (  math.max ( 0 ,  0.03 * lv_dis ) , 0.15 )  
	end 
	local dif_hit_flee = Flee(b) - Hit(a) 
	local bsmiss = math.max( ((def_flee - atk_hit) + 10)/100 , 0) 
	local miss = math.min( 0.9, bsmiss ) --[[��miss��]]--
	--LG("Mis or Crt", "miss�� = ", miss, "\n") 
	local crt = math.min ( lv_eff + Crt( a ) , 1 ) 
	--LG ( "Mis or Crt" , " ԭʼcrt�� = " , Crt(a) ) 
	--LG("Mis or Crt", "crt�� = ", crt, "\n") 
	local sus,dmgsa=Mis_or_Crt( miss, crt ) --[[����miss��crt��]]--
	--LG("Mis or Crt", "����״̬sus = ", sus, "����״̬�˺����� dmgsa = ", dmgsa, "\n") 
	--LG("Mis or Crt" , "End function Check_MisorCrt(a,b) --[[�ж��Ƿ�miss��crt]]--", "\n") 
	--LuaPrint("Out function Check_MisorCrt(a,b) --[[�ж��Ƿ�miss��crt]]--") 
	return sus,dmgsa 
end 




function SkillArea_Circle_Paodan( sklv )													--[[����"�ڵ���ͨ����"�Ľ�ɫӰ������]]--
		local side = 400 
		SetSkillRange ( 4 , side )  
end 

function Skill_Paodan_Begin ( role , sklv ) 
end 

function Skill_Paodan_End ( ATKER , DEFER , sklv )	--[[����"�ڵ���ͨ����"�Ľ�ɫӰ��������˺����㣨����miss�ͱ������㣩]]--
		skr_posx, skr_posy = GetSkillPos ( ATKER ) 				--[[ȡ�ü��ܵ�ʩ������]]--
--		LG ("paodan"," skr_posx = ", skr_posx," skr_posy = ", skr_posy ) 
		if ValidCha( DEFER ) == 0 then 
			CALCULATE_SKILLEFFECT_LUA_000015 = GetResString("CALCULATE_SKILLEFFECT_LUA_000015")
			LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000015 ) 
			return 
		end 
		role_posx, role_posy = GetChaPos( DEFER )				--[[ȡ��Ӱ���ɫ������]]--
--		LG ( "paodan" , " role_posx = ", role_posx , " role_posy = ", role_posy ) 
		local dmg = Fire_Dmg( ATKER , DEFER )					--[[������ͨ���������������˺�]]--
--		SetSus(DEFER , sus)								--���ñ�����miss 
		local dis = Dis ( skr_posx, skr_posy, role_posx, role_posy  )		--[[�����ɫ������ʩ�ŵ�ľ���]]--
--		hpdmg = math.floor ( dmg * dmgsa )					--[[ȡ�����˺�����С�˺��е����ֵ,��miss�ͱ����˺�]]--
		local dis_eff = dis/100 * 0.1  
--		LG("Fire_Dmg"," dis_eff = " , dis_eff ) 
		dmg = math.floor ( dmg * (1 - math.min ( dis_eff, 1 ) ) ) 
--		LG("Fire_Dmg"," real_hpdmg = " , dmg ) 
		Hp_Endure_Dmg ( DEFER, dmg )							--[[�����ܻ��߿�Ѫ]]--
end 

--function SkillArea_Circle_Huoqiang ( sklv )							
--		local side = 0 
--end 

function Skill_Huoqiang_Begin ( role , sklv ) 
end 

function Skill_Huoqiang_End ( ATKER , DEFER , sklv ) --[[����"������ͨ����"���˺����㣨����miss�ͱ������㣩]]--
		local js_dmg = 1 
		dmg = Fire_Dmg( ATKER, DEFER )	 * js_dmg			--[[������ͨ���������������˺�]]--
		sus,dmgsa = Check_MisorCrt( ATKER, DEFER )			--[[�Ƿ�miss��crt]]--
		SetSus(DEFER , sus)								--���ñ�����miss 
		hpdmg = math.floor( dmg*dmgsa )				--[[ȡ�����˺�����С�˺��е����ֵ,��miss�ͱ����˺�]]--
		Hp_Endure_Dmg( DEFER , hpdmg )						--[[�����ܻ��߿�Ѫ]]--
end 









--���ܻ�Х������������������������������������������������������������������������������������������������������������������������������������������������������������


function SkillArea_Circle_Hx ( sklv )									--���ܡ���Х"�ļ�������ʽ
	local side = 200 
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_Hx( sklv )
	local Cooldown = 20000
	return Cooldown
end


function SkillSp_Hx ( sklv )										--����"��Х"��sp���Ĺ�ʽ
	local sp_reduce = 20 
	return sp_reduce 
end 

function Skill_Hx_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Hx ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Hx_End ( ATKER , DEFER , sklv ) 
	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 15
	AddState( ATKER , DEFER , STATE_HX, statelv , statetime ) 
end 

function State_Hx_Add ( role , statelv ) 
	--LG("state_hx" , "function State_Hx_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mxatksb_dif = 3 * statelv
	local mnatksb_dif = 3 * statelv
	local mspdsa_dif = 0.015 * statelv 
	local mxatksb = ( MxatkSb(role) - mxatksb_dif ) 
	local mnatksb = ( MnatkSb(role) - mxatksb_dif ) 
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK )
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 



function State_Hx_Rem ( role , statelv ) 
	--LG("state_hx" , "function State_Hx_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mxatksb_dif = 3 * statelv
	local mnatksb_dif = 3 * statelv
	local mspdsa_dif = 0.015 * statelv 
	local mxatksb = ( MxatkSb(role) + mxatksb_dif ) 
	local mnatksb = ( MnatkSb(role) + mxatksb_dif ) 
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK )
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role) 
end 






--������ʹ��Ը������������������������������������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Tsqy ( sklv )										
	local sp_reduce = sklv * 1 
	return sp_reduce 
end

function SkillCooldown_Tsqy( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_Tsqy_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Tsqy(sklv) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Tsqy_End ( ATKER , DEFER , sklv )  
	local statelv = sklv 
	local statetime = 5 + sklv * 2
   --LG( "Tsqy", "��ʹ��Ը���ܵȼ� = " , sklv , "\n" ) 
   AddState( ATKER , DEFER , STATE_TSQY, statelv , statetime )
	--LG("skill_Tsqy", "function Skill_Oper_Tsqy: " , "add state tsqy " , "\n" ) 


end 

function State_Tsqy_Add ( role , statelv ) 
	--LG("state_tsqy" , "function State_Tsqy_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local hrecsa_dif =0.03 * statelv 
	local hrecsa = (HrecSa(role) + hrecsa_dif ) * ATTR_RADIX
	--LG("skill_tsqy" , " form_hrecsa = " , HrecSa(role) , "\n" ) 
	--LG("skill_tsqy", "hrecsa = ", hrecsa, "\n") 
	--LG("skill_hrecsa" , " form_hrecsa = " , HrecSa(role) , "\n" ) 
	--LG("skill_hrecsa", "hrecsa = ", hrecsa, "\n") 
	SetCharaAttr( hrecsa , role , ATTR_STATEC_HREC ) 
	ALLExAttrSet(role)  
end 

function State_Tsqy_Rem ( role , statelv ) 
	--LG("state_tqsy" , "function State_Tsqy_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local hrecsa_dif = 0.03 * statelv 
	local hrecsa = (HrecSa(role) - hrecsa_dif ) * ATTR_RADIX
	if hrecsa < 0 then 
		--LG("Luaerror", "function State_Oper_Tsqy : �������ݽ������", " Hrecsa = ", HrecSa(role) , " statelv = " , statelv , " hrecsa = ", hrecsa , "\n" ) 
		return 
	end 
	--LG("skill_tsqy" , " form_hrecsa = " , HrecSa(role) , "\n" ) 
	--LG("skill_tsqy", "hrecsa = ", hrecsa, "\n") 
	--LG("skill_hrecsa" , " form_hrecsa = " , HrecSa(role) , "\n" ) 
	--LG("skill_hrecsa", "hrecsa = ", hrecsa, "\n") 
	SetCharaAttr( hrecsa , role , ATTR_STATEC_HREC )
	ALLExAttrSet(role)  
end 







	





--���ܽⶾ������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Jd ( sklv )										
	local sp_reduce = sklv * 1 
	return sp_reduce 
end

function SkillCooldown_Jd( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_Jd_Begin ( role , sklv ) 
	--LG( "skill_jd", "enter function Skill_Atk_Jd : " , "\n" ) 
	--LG("skill_jd", "function Skill_Atk_Jd : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Jd ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Jd_End ( ATKER , DEFER , sklv ) 
	--LG( "skill_jd", "enter function Skill_Def_Jd : " , "\n" ) 
	local jd_statelv = sklv 
	local zd_statelv = GetChaStateLv ( DEFER , STATE_ZD ) 
	RemoveState ( DEFER , STATE_ZD ) 
	--LG("skill_jd", "function Skill_Def_Jd : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	Check_Ys_Rem (ATKER , DEFER ) 

end 

--�����ռ���ä������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Zjcm ( sklv )										
	local sp_reduce = sklv * 1 
	return sp_reduce 
end

function SkillCooldown_Zjcm( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_Zjcm_Begin ( role , sklv ) 
	--LG( "skill_zjcm", "enter function Skill_Atk_Zjcm : " , "\n" ) 
	--LG("skill_zjcm", "function Skill_Atk_Zjcm : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Zjcm ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Zjcm_End ( ATKER , DEFER , sklv ) 
	--LG( "skill_zjcm", "enter function Skill_Def_Zjcm : " , "\n" ) 
	local statelv = sklv 
	local statetime = 5 + sklv * 2 
	local zjcm_rad = 0.3 + sklv * 0.05  
	local atk_dire = GetObjDire ( ATKER ) 
	local def_dire = GetObjDire ( DEFER ) 		
	dif_dire = atk_dire - def_dire 
	if math.abs(dif_dire) < 90 or math.abs(dif_dire) > 180 then 
		zjcm_rad = xy_rad * 1.25 
	end 
	a = Percentage_Random ( zjcm_rad ) 
	if a == 1 then 
		AddState ( ATKER , DEFER , STATE_SM , statelv , statetime ) 
	end 
	--LG("skill_zjcm", "function Skill_Def_Zjcm : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	Check_Ys_Rem ( ATKER , DEFER ) 

end 


function State_Sm_Add ( role , statelv ) 
	--LG("state_Sm" , "function State_Sm_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 

end 

function State_Sm_Rem ( role , statelv ) 
	--LG("state_Sm" , "function State_Sm_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 

end 



--���ܱ�˪���ܡ�������������������������������������������������������������������������������������������������������������������

function SkillSp_Bshd ( sklv )										
	local sp_reduce = sklv * 1 
	return sp_reduce 
end

function SkillCooldown_Bshd( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_Bshd_Begin ( role , sklv ) 
	--LG( "skill_bshd", "enter function Skill_Atk_Bshd : " , "\n" ) 
	--LG("skill_bshd", "function Skill_Atk_Bshd : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Bshd ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Bshd_End ( ATKER , DEFER , sklv ) 
	--LG( "skill_bshd", "enter function Skill_Def_Bshd : " , "\n" ) 
	local statelv = sklv 
	local statetime = 5 + sklv * 2 
	AddState ( ATKER , DEFER , STATE_BSHD , statelv , statetime ) 
	--LG("skill_bshd", "function Skill_Def_Bshd : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
end 


function State_Bshd_Add ( role , statelv ) 
	--LG("state_Bshd" , "function State_Bshd_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local defsb_dif = 5 + statelv * 2 
	local defsb = DefSb(role) + defsb_dif 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 
	ALLExAttrSet(role)  
end 

function State_Bshd_Rem ( role , statelv ) 
	--LG("state_Bshd" , "function State_Bshd_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local defsb_dif = 5 + statelv * 2 
	local defsb = DefSb(role) - defsb_dif 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 
	ALLExAttrSet(role)  
end 
















--��������֮��������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Lyzy ( sklv )										--����"����֮��"��sp���Ĺ�ʽ
	local sp_reduce = sklv * 1 
	return sp_reduce 
end 

function SkillCooldown_Lyzy( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_Lyzy_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Lyzy ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Lyzy_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 10 + sklv * 2
	AddState( ATKER , DEFER , STATE_LYZY , statelv , statetime ) 
	--LG( "Lyzy", "����֮�����ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 

end 

--����ʥ��֮�⡪����������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Shzg ( sklv )										--����"ʥ��֮��"��sp���Ĺ�ʽ
	local sp_reduce = sklv * 1 
	return sp_reduce 
end 

function SkillCooldown_Shzg( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_Shzg_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Shzg ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Shzg_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 10 + sklv * 2
	AddState( ATKER , DEFER , STATE_SHZG , statelv , statetime ) 
	--LG( "Shzg", "ʥ��֮�⼼�ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
end 


--���ܴ��ִ�Խ����������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Clcy ( sklv )										--����"���ִ�Խ"��sp���Ĺ�ʽ
	local sp_reduce = sklv * 1 
	return sp_reduce 
end 

function SkillCooldown_Clcy( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_Clcy_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Clcy ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Clcy_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 3 + sklv * 2
	AddState( ATKER , DEFER , STATE_CLCY, statelv , statetime ) 
	--LG( "Clcy", "���ִ�Խ���ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
end 

function State_Clcy_Add ( role , statelv ) 
	local mspdsb_dif = 100 + statelv * 10 
	local mspdsb = MspdSb(role) + mspdsb_dif 
	SetCharaAttr( mspdsb , role , ATTR_STATEV_MSPD ) 
	ALLExAttrSet(role)  
end 

function State_Clcy_Rem ( role , statelv ) 
	local mspdsb_dif = 100 + statelv * 10 
	local mspdsb = MspdSb(role) - mspdsb_dif 
	SetCharaAttr( mspdsb , role , ATTR_STATEV_MSPD ) 
	ALLExAttrSet(role)  
end 


--���ܻ������䡪����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillPre_Hyps ( sklv )														--����"��������"�ļ���ǰ��׼��
end 

function SkillCooldown_Hyps( sklv )
	local Cooldown = 2000
	return Cooldown
end

function SkillArea_Square_Hyps ( sklv )												--���ܡ���������"�ļ�������ʽ
	local side = 250 
	local angle = 90 
	SetSkillRange ( 2 , side , angle )   
end 

function SkillArea_State_Hyps ( sklv )										
	local statetime = 10 + sklv * 5 
	local statelv = sklv 
	--LG("SkillPre_Hyps" , " fucntion SkillPre_Hyps :" , " statelv = " , statelv , "statetime " , statetime ) 
	SetRangeState ( STATE_RS , statelv  , statetime ) 									--���ӵ��桰�������䡱״̬
end 

function SkillSp_Hyps ( sklv )														--���ܡ��������䡱��sp���Ĺ�ʽ
	local sp_reduce = sklv * 1 
	return sp_reduce 
end 

function Skill_Hyps_Begin ( role , sklv )												--����"��������"�ļ���ʩ�Ź�ʽ
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Hyps ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Hyps_End ( ATKER , DEFER , sklv ) 
	local hpdmg = sklv * 100 
	local hp = GetChaAttr(DEFER) 
	Hp_Endure_Dmg( DEFER , hpdmg ) 
end 


function State_Hyps_Add ( role , statelv ) 
	--LG("state_rs" , "function State_Hyps_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local arealv = GetAreaStateLevel ( role , STATE_HYPS ) 
	local hp = GetChaAttr( role , ATTR_HP ) 
	local hpdmg = statelv * 10  
		if arealv >= 1 then 
			hpdmg = statelv * 50 
		end 
	Hp_Endure_Dmg ( role , hpdmg ) 
end 

function State_Hyps_Rem ( role , statelv ) 
end 


function State_Hyps_Tran ( statelv ) 
	return 2   
end 

--���ܿ�����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Ks ( sklv ) 
	return 0 
end 

function SkillCooldown_Ks( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_Ks_Begin  ( role , sklv ) 
end 

function Skill_Ks_End ( ATKER , DEFER , sklv ) 
	CALCULATE_SKILLEFFECT_LUA_000016 = GetResString("CALCULATE_SKILLEFFECT_LUA_000016")
	SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000016 ) 
	local defer_lv = GetChaAttr ( DEFER , ATTR_LV ) 
	if sklv < defer_lv then 
		CALCULATE_SKILLEFFECT_LUA_000017 = GetResString("CALCULATE_SKILLEFFECT_LUA_000017")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000017 ) 
		return 
	end 
	local hpdmg = 1 
	
	local UnNormal_Tree_ID = 778

	local Tree_ID = GetChaTypeID( DEFER )
	local Tree_hp = Hp( DEFER )
	local i = 0
	
	if Tree_ID == UnNormal_Tree_ID then
		if Tree_hp <= 800 then
			hpdmg = 0
			CALCULATE_SKILLEFFECT_LUA_000018 = GetResString("CALCULATE_SKILLEFFECT_LUA_000018")
			SystemNotice( ATKER , CALCULATE_SKILLEFFECT_LUA_000018 )
		end
	end

	local hp = Hp(DEFER) - hpdmg 
--	LG ( "sk_ks" , " tree_hp = "  , Hp(DEFER) ) 
	SetCharaAttr(hp , DEFER , ATTR_HP ) 
--	LG ( "sk_ks" , " now_tree_hp = "  , Hp(DEFER) ) 
--	local hp = Hp(DEFER) - hpdmg 
--	SetCharaAttr(hp , DEFER , ATTR_HP ) 

--	local KanShu_Check =  0

--	KanShu_Check = Percentage_Random(0.01)
--		if  KanShu_Check == 1  then 
--		 GiveItem( ATKER ,  0 , 435, 1, 4)	
	 
--		end	 
end 






--�����ڿ󡪡�����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Wk( sklv ) 
	return 0 
end 

function SkillCooldown_Wk( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_Wk_Begin  ( role , sklv ) 
end 

function Skill_Wk_End ( ATKER , DEFER , sklv ) 
	local Item_Use = GetChaItem ( ATKER , 1 , 9 )			----ȡ����װ���ĵ���
	local ItemID_Use = GetItemID ( Item_Use )			----ȡID
	if ItemID_Use == 6538 or ItemID_Use == 6539 then
		CALCULATE_SKILLEFFECT_LUA_000019 = GetResString("CALCULATE_SKILLEFFECT_LUA_000019")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000019)
		return 
	end
	local defer_lv = Lv ( DEFER ) 

	if sklv < defer_lv then 
		CALCULATE_SKILLEFFECT_LUA_000017 = GetResString("CALCULATE_SKILLEFFECT_LUA_000017")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000017 ) 
		return 
	end 
	
	local hpdmg = 1 

	local UnNormal_KS_ID = 777

	local KS_ID = GetChaTypeID( DEFER )
	local KS_hp = Hp( DEFER )
	local i = 0
	
	if KS_ID == UnNormal_KS_ID then						----�ж��Ƿ�����ʯ

		local Item_Use = GetChaItem ( ATKER , 1 , 9 )			----ȡ����װ���ĵ���
		local ItemID_Use = GetItemID ( Item_Use )			----ȡID
	
	
		
		if ItemID_Use ~= 3908 and ItemID_Use ~= 3108 then					----������ǺϽ��䲻����
			CALCULATE_SKILLEFFECT_LUA_000020 = GetResString("CALCULATE_SKILLEFFECT_LUA_000020")
			SystemNotice( ATKER , CALCULATE_SKILLEFFECT_LUA_000020 )
			return
		end

		local Item_URE = GetItemAttr ( Item_Use , ITEMATTR_URE )	----ȡ�Ͻ����;�
		
		local Take_Num = 0

		local URE_Ran = Percentage_Random ( 0.35 )
		
		if URE_Ran == 1 then
			Take_Num = 1
		end
		
		if Item_URE < 50 then						----�;�Ϊ0������
			Take_Num = 0
			hpdmg = 0
			CALCULATE_SKILLEFFECT_LUA_000021 = GetResString("CALCULATE_SKILLEFFECT_LUA_000021")
			SystemNotice( ATKER , CALCULATE_SKILLEFFECT_LUA_000021 )
		end

		Item_URE = Item_URE - Take_Num

		local i = SetItemAttr ( Item_Use , ITEMATTR_URE , Item_URE )	----���;�
		if i == 0 then
			CALCULATE_FUNCTIONS_LUA_000045 = GetResString("CALCULATE_FUNCTIONS_LUA_000045")
			LG("Item_URE",CALCULATE_FUNCTIONS_LUA_000045)
		end
		if Item_URE < 50 and Take_Num ~= 0 then
			SetChaEquipValid ( role , 9 , 0 )			----����װ����Ч
		end


		if KS_hp <= 800 then
			hpdmg = 0
			CALCULATE_SKILLEFFECT_LUA_000022 = GetResString("CALCULATE_SKILLEFFECT_LUA_000022")
			SystemNotice( ATKER , CALCULATE_SKILLEFFECT_LUA_000022 )
		end
--	else local WaKuang_Check =  0

--		WaKuang_Check = Percentage_Random(0.01)
		
--		if  WaKuang_Check == 1  then 
--		 GiveItem( ATKER ,  0 , 433, 1, 4)	
			 
--		end	
	end

	local hp = Hp(DEFER) - hpdmg 
	SetCharaAttr(hp , DEFER , ATTR_HP ) 
           
	 
	
end 

--���ܲ��㡪������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_By ( sklv ) 
	return 0 
end 

function SkillCooldown_By( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_By_Begin  ( role , sklv ) 
end 

function Skill_By_End ( ATKER , DEFER , sklv ) 
--	SystemNotice ( ATKER , " ��ʼ���㿩��" ) 
	local defer_lv = Lv ( DEFER ) 
	if sklv < defer_lv then 
		CALCULATE_SKILLEFFECT_LUA_000017 = GetResString("CALCULATE_SKILLEFFECT_LUA_000017")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000017 ) 
		return 
	end 
	CALCULATE_SKILLEFFECT_LUA_000023 = GetResString("CALCULATE_SKILLEFFECT_LUA_000023")
	SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000023 ) 
	local hpdmg = 1 
	local hp = Hp(DEFER) - hpdmg 
--	LG ( "sk_by" , "fish_hp = " , Hp(DEFER) ) 
--	LG ( "sk_by" , "fish_nowhp = " , hp ) 
	SetCharaAttr(hp , DEFER , ATTR_HP ) 
--	local hp = Hp(DEFER) - hpdmg 
--	SetCharaAttr(hp , DEFER , ATTR_HP ) 

--	local BuYu_Check =  0

--	BuYu_Check = Percentage_Random(0.01)
--		if  BuYu_Check == 1  then 
--		 GiveItem( ATKER ,  0 , 434, 1, 4)	
	 
--		end
end 

--���ܴ��̡�������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Dl ( sklv ) 
	return 0 
end 

function SkillCooldown_Dl( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_Dl_Begin  ( role , sklv ) 
end 

function Skill_Dl_End ( ATKER , DEFER , sklv ) 
--	SystemNotice ( ATKER , " ��ʼ���̿���" ) 
	local defer_lv = Lv ( DEFER ) 
	if sklv < defer_lv then 
		CALCULATE_SKILLEFFECT_LUA_000017 = GetResString("CALCULATE_SKILLEFFECT_LUA_000017")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000017 ) 
		return 
	end 
		CALCULATE_SKILLEFFECT_LUA_000024 = GetResString("CALCULATE_SKILLEFFECT_LUA_000024")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000024 ) 
	local hpdmg = 1 
	local hp = Hp(DEFER) - hpdmg 
	SetCharaAttr(hp , DEFER , ATTR_HP ) 
	
--	local DaLao_Check =  0
-- SystemNotice ( ATKER , " 1" ) 

--	DaLao_Check = Percentage_Random(0.01)
--SystemNotice ( ATKER , DaLao_Check  ) 
--		if  DaLao_Check == 1  then 
--		 GiveItem( ATKER ,  0 , 432, 1, 4)	
	 
--		end
end 















--���ܼ��ٷ籩����������������������������������������������������������������������������������������������������������������������������
function SkillSp_Jsfb ( sklv )										
	local sp_reduce = 20
	return sp_reduce 
end

function SkillCooldown_Jsfb( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_Jsfb_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Jxwb (sklv) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Jsfb_End ( ATKER , DEFER , sklv )  
	local statelv = sklv 
	local statetime = 30 + sklv * 3 
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local str_atker = Str(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then
			 statetime =math.max(30,math.floor(str_atker/5))+sklv*3
		--		Notice ( "statetime="..statetime)
			end
		end

        --LG( "Jxwb", "���ٷ籩���ܵȼ� = " , sklv , "\n" ) 
        AddState( ATKER , DEFER , STATE_JSFB, statelv , statetime ) 
	--LG("skill_Jxwb", "function Skill_Oper_Jxwb: " , "add state Jxwb " , "\n" ) 
---------------������״̬
	CheckAttackState1( ATKER , DEFER )	
		
end 

function State_Jsfb_Add ( role , statelv ) 
	--LG("state_Jxwb" , "function State_Jxwb_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local crtsb_dif =5 + 1 * statelv 
	local crtsb = math.floor ( (CrtSb(role) + crtsb_dif ) ) 
	SetCharaAttr( crtsb , role , ATTR_STATEV_CRT ) 
	ALLExAttrSet(role)  
end 



function State_Jsfb_Rem ( role , statelv ) 
	--LG("state_jxwb" , "function State_jxwb_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local crtsb_dif =5 + 1 * statelv 
	local crtsb = math.floor ( (CrtSb(role) - crtsb_dif ) ) 
	SetCharaAttr( crtsb , role , ATTR_STATEV_CRT ) 
	ALLExAttrSet(role)  
end 



--�������߷�ӡ������������������������������������������������������������������������������������������������������������������������������������������������������������


function SkillSp_Xzfy ( sklv )										--����"���߷�ӡ"��sp���Ĺ�ʽ
	local sp_reduce = 30 + sklv * 2 
	return sp_reduce 
end 

function SkillCooldown_Xzfy( sklv )
	local Cooldown = 20000
	return Cooldown
end

function Skill_Xzfy_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Xzfy ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Xzfy_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 10 + math.floor ( sklv* 0.5  ) 
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local con_atker = Con(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then
			 statetime =math.max(10,math.floor(con_atker/15))+sklv* 0.5
	--			Notice ( "statetime="..statetime)
			end
		end
	local Check_Heilong  = CheckItem_Heilong ( ATKER )
	if Check_Heilong == 1 then
		local Percentage = Percentage_Random ( 0.7)
			if Percentage == 1 then
				  statetime =  statetime*1.5
				CALCULATE_FUNCTIONS_LUA_000004 = GetResString("CALCULATE_FUNCTIONS_LUA_000004")
				SystemNotice ( ATKER , CALCULATE_FUNCTIONS_LUA_000004)
			end
	end
		local Check_namei  = CheckItem_namei ( ATKER )
		if Check_namei == 1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				  statetime =  statetime*2 
				CALCULATE_SKILLEFFECT_LUA_000025 = GetResString("CALCULATE_SKILLEFFECT_LUA_000025")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000025)
			end
		end
		
		local Check_lufei  = CheckItem_lufei ( ATKER )
		if Check_lufei == 1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				  statetime =  statetime*2 
				CALCULATE_SKILLEFFECT_LUA_000026 = GetResString("CALCULATE_SKILLEFFECT_LUA_000026")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000026)
			end
	end

	local hp_defer = Hp ( DEFER ) 
	if hp_defer >= 100000 then 
		local a = Percentage_Random (0.8)
		if a == 1 then
			statetime = 5 + math.floor ( sklv * 0.3 ) 
		else
			SetSus( DEFER , 0 ) 
			CALCULATE_SKILLEFFECT_LUA_000027 = GetResString("CALCULATE_SKILLEFFECT_LUA_000027")
			SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000027) 
			return
		end
	end 
	----bossʹ�ü��ܴ���
	if GetChaTypeID( ATKER ) == 985 then
		statetime = 15
		statelv = 10
	end
	if GetChaAIType( DEFER ) >= 21 then    --21����ΪBossAI�������Boss����boss��ͬ���趨���Ա���״̬�Ĵ���
		if BOSSXZSJ[GetChaTypeID( DEFER )] == 0 then
			CALCULATE_SKILLEFFECT_LUA_000028 = GetResString("CALCULATE_SKILLEFFECT_LUA_000028")
			Notice (CALCULATE_SKILLEFFECT_LUA_000028)
			return
		else
			BOSSXZSJ[GetChaTypeID( DEFER )] = BOSSXZSJ[GetChaTypeID( DEFER )] -1
		end
	end

	----bossʹ�ü��ܴ�������
	AddState( ATKER , DEFER , STATE_XY , 1 , 3 )
	AddState ( ATKER , DEFER ,STATE_JNJZ , statelv , statetime ) 
----------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
end 

--���ܰ�Ӱ֮�¡���������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Ayzz ( sklv )										--����"��Ӱ֮��"��sp���Ĺ�ʽ
	local sp_reduce = 30 + sklv * 3  
	return sp_reduce 
end 

function SkillCooldown_Ayzz( sklv )
	local Cooldown = 30000
	return Cooldown
end

function Skill_Ayzz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Ayzz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Ayzz_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 5 + sklv * 1
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local con_atker = Con(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then
			 statetime =math.max(5,math.floor(con_atker/30))+sklv
	--			Notice ( "statetime="..statetime)
			end
		end
	local Check_Heilong  = CheckItem_Heilong ( ATKER )
	if Check_Heilong == 1 then
		local Percentage = Percentage_Random ( 0.7)
			if Percentage == 1 then
				  statetime =  statetime*1.5
				CALCULATE_FUNCTIONS_LUA_000004 = GetResString("CALCULATE_FUNCTIONS_LUA_000004")
				SystemNotice ( ATKER , CALCULATE_FUNCTIONS_LUA_000004)
			end
	end
	local hp_defer = Mxhp ( DEFER )
	if hp_defer >= 100000 and hp_defer < 1000000 then 
		local a = Percentage_Random (0.7)
		if a == 1 then
			statetime = 9
		else
			SetSus( DEFER , 0 )
			return
		end
	elseif hp_defer >= 1000000 then 
		local a = Percentage_Random (0.7)
		if a == 1 then
			statetime = 4
		else
			SetSus( DEFER , 0 )
			return
		end
	end 
	----bossʹ�ü��ܴ���
	if GetChaTypeID( ATKER ) == 985 then
		statetime = 15
		statelv = 10
	end
	if GetChaAIType( DEFER ) >= 21 then    --21����ΪBossAI�������Boss����boss��ͬ���趨���Ա���״̬�Ĵ���
		if BOSSAYSJ[GetChaTypeID( DEFER )] == 0 then
			CALCULATE_SKILLEFFECT_LUA_000028 = GetResString("CALCULATE_SKILLEFFECT_LUA_000028")
			Notice (CALCULATE_SKILLEFFECT_LUA_000028)
			return
		else
			BOSSAYSJ[GetChaTypeID( DEFER )] = BOSSAYSJ[GetChaTypeID( DEFER )] -1
		end
	end
	----bossʹ�ü��ܴ�������
	local statelv1 = New_Xlcz ( ATKER , DEFER )
	AddState( ATKER , DEFER , STATE_GJJZ, statelv1 , statetime ) 
	--LG( "Ayzz", "��Ӱ֮�¼��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
----------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
			
end 


--����ӥ�ۡ�����������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Yy ( sklv )										--����"ӥ��"��sp���Ĺ�ʽ
	local sp_reduce = 10  
	return sp_reduce 
end 

function SkillCooldown_Yy( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_Yy_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Yy ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Yy_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 20 + sklv * 10   
	AddState( ATKER , DEFER , STATE_YY, statelv , statetime ) 
end 

function State_Yy_Add ( role , statelv ) 
	--LG("state_Yy" , "function State_Yy_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local hitsb_dif = statelv * 3 
	local hitsb = HitSb(role) + hitsb_dif 
	SetCharaAttr ( hitsb , role , ATTR_STATEV_HIT ) 
	ALLExAttrSet(role)  
end 

function State_Yy_Rem ( role , statelv ) 
	--LG("state_Yy" , "function State_Yy_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local hitsb_dif = statelv * 3 
	local hitsb = HitSb(role) - hitsb_dif 
	SetCharaAttr ( hitsb , role , ATTR_STATEV_HIT ) 
	ALLExAttrSet(role)  
end 




--������������������������������������������������������������������������������������������������������������������������������������������������������������������


function SkillSp_Lzj ( sklv )										--����"�����"��sp���Ĺ�ʽ
	local sp_reduce = 20  
	return sp_reduce 
end 

function SkillCooldown_Lzj( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_Lzj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Lzj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Lzj_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000029 = GetResString("CALCULATE_SKILLEFFECT_LUA_000029")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000029 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000030 = GetResString("CALCULATE_SKILLEFFECT_LUA_000030")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000030 ) 
		return 
	end 
		hpdmg = ( 1.5+sklv * 0.15 ) * Atk_Dmg ( ATKER , DEFER ) 
		Hp_Endure_Dmg ( DEFER , hpdmg )  
		--LG( "Lzj", "��������ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
-------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
end 


--��������ǿ������������������������������������������������������������������������������������������������������������������������������������������������������


function SkillSp_Hxqj ( sklv )										--����"����ǿ��"��sp���Ĺ�ʽ
   local sp_reduce = 20 + sklv * 2 
	return sp_reduce 
end 

function SkillCooldown_Hxqj( sklv )
	local Cooldown = 10000
	return Cooldown
end

function Skill_Hxqj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Hxqj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Hxqj_End ( ATKER , DEFER , sklv ) 
	local back_dis = 300 + sklv * 30 
	atk = ( 1.5 + sklv * 0.1 ) * math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
	defer_def = Def ( DEFER ) 
	defer_resist = Resist ( DEFER ) 
	dmg = Phy_Dmg ( atk, defer_def , defer_resist ) 
	Hp_Endure_Dmg ( DEFER , dmg )  
	BeatBack ( ATKER , DEFER , back_dis )
	--LG( "Hxqj", "����ǿ�����ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 

end 


--���ܻ�Ӱն����������������������������������������������������������������������������������������������������������������������������������������������������


function SkillSp_Hyz ( sklv )										--����"��Ӱն"��sp���Ĺ�ʽ
   local sp_reduce = 20 
	return sp_reduce 
end 

function SkillCooldown_Hyz( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_Hyz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Hyz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Hyz_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000031 = GetResString("CALCULATE_SKILLEFFECT_LUA_000031")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000031 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000032 = GetResString("CALCULATE_SKILLEFFECT_LUA_000032")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000032 ) 
		return 
	end 
	local aspd = Aspd ( ATKER )
--	local dmg = ( ( 1.5 + 0.1 * sklv ) ) * (math.min(3,( math.max ( 1, math.floor( aspd / 70  ) )  ))) * Atk_Dmg ( ATKER , DEFER )
	local dmg = 0
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local agi_atker = Agi(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then
				dmg = ( ( 1 + 0.1 * sklv ) ) * (math.min(3,( math.max ( 1, math.floor( aspd / 70  ) )  ))) * Atk_Dmg ( ATKER , DEFER )
	--			Notice ( "dmg="..dmg)
			end
		end
	Hp_Endure_Dmg ( DEFER , dmg )
	if IsPlayer(DEFER) == 1 and IsPlayer(ATKER) == 1 then
		CALCULATE_SKILLEFFECT_LUA_000033 = GetResString("CALCULATE_SKILLEFFECT_LUA_000033")
		SkillLog(ATKER,DEFER,dmg,CALCULATE_SKILLEFFECT_LUA_000033,sklv)
	end
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
--------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
end 

--�����ػ�����������������������������������������������������������������������������������������������������������������������������������������������������


function SkillSp_Zj ( sklv )										--����"�ػ�"��sp���Ĺ�ʽ
   local sp_reduce = 8 + sklv * 1  
	return sp_reduce 
end 

function SkillCooldown_Zj( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_Zj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Zj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Zj_End ( ATKER , DEFER , sklv ) 
	atk_rad = 1.2 + sklv * 0.05 
	hpdmg = Atk_Raise ( atk_rad , ATKER , DEFER )	
	Hp_Endure_Dmg ( DEFER , hpdmg )  
	--LG( "Zj", "�ػ����ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
	Check_Ys_Rem ( ATKER ,DEFER )						--�ж��Ƿ�����
-------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
end 
--���ܷ���--------------------------------------------------------------------------------------------------------------------------------------------------------------------

function SkillSp_Fnq ( sklv )										--����"����"��sp���Ĺ�ʽ
	local sp_reduce = 25 
	return sp_reduce 
end 

function SkillCooldown_Fnq( sklv )
	local Cooldown = 25000
	return Cooldown
end

function Skill_Fnq_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Fnq ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Fnq_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 20
----bossʹ�ü��ܴ���
	if GetChaTypeID( ATKER ) == 983 then
		statetime = 120
		statelv = 10
	end
----bossʹ�ü��ܴ�������

	AddState( ATKER , DEFER , STATE_FNQ, statelv , statetime ) 
	--LG( "Fnq", "�����ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
end 

function State_Fnq_Add ( role , statelv ) 
	--LG("state_Fnq" , "function State_Fnq_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local aspd_dif = 10 + 1 * statelv 
	local aspdsb = ( AspdSb(role) + aspd_dif ) 
	SetCharaAttr( aspdsb , role , ATTR_STATEV_ASPD ) 
	ALLExAttrSet(role)  
end 

function State_Fnq_Rem ( role , statelv ) 
	--LG("state_Fnq" , "function State_Fnq_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local aspd_dif = 10 + 1 * statelv 
	local aspdsb = ( AspdSb(role) - aspd_dif ) 
	SetCharaAttr( aspdsb , role , ATTR_STATEV_ASPD ) 
	ALLExAttrSet(role)  
end

--���ܿ񱩡�������������������������������������������������������������������������������������������������������������������������������������������������������������������


function SkillSp_Kb ( sklv )										--����"��"��sp���Ĺ�ʽ
	local sp_reduce = 15 
	return sp_reduce 
end 

function SkillCooldown_Kb( sklv )
	local Cooldown = 35000
	return Cooldown
end

function Skill_Kb_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Kb ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Kb_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 20  
	AddState( ATKER , DEFER , STATE_KB, statelv , statetime ) 
	--LG( "Kb", "�񱩼��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
-----------������״̬
	CheckAttackState1( ATKER , DEFER )
	
end 

function State_Kb_Add ( role , statelv ) 
	--LG("state_kb" , "function State_Kb_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local aspdsa_dif = 0.2 + statelv * 0.015
	local aspdsa = ( AspdSa(role) + aspdsa_dif) * ATTR_RADIX
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet(role)  
end 

function State_Kb_Rem ( role , statelv ) 
	--LG("state_kb" , "function State_Kb_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local aspdsa_dif = 0.2 + statelv * 0.015
	local aspdsa = ( AspdSa(role) - aspdsa_dif) * ATTR_RADIX
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet(role)  
end 

--��������������������������������������������������������������������������������������������������������������������������������������������������������������


function SkillSp_Swzq ( sklv )										--����"����֮ȭ"��sp���Ĺ�ʽ
   local sp_reduce = 50+sklv*3  
	return sp_reduce 
end 

function SkillCooldown_Swzq( sklv )
	local Cooldown = 45000
	return Cooldown
end

function Skill_Swzq_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Swzq ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Swzq_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000034 = GetResString("CALCULATE_SKILLEFFECT_LUA_000034")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000034 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000035 = GetResString("CALCULATE_SKILLEFFECT_LUA_000035")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000035 ) 
		return 
	end 
	
	dmg = ( 3 +  sklv * 0.5 ) * Atk_Dmg ( ATKER ,DEFER ) 
		
	local Check_lufei  = CheckItem_lufei ( ATKER )

	if Check_lufei == 1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				  dmg =  dmg*5 
				CALCULATE_SKILLEFFECT_LUA_000036 = GetResString("CALCULATE_SKILLEFFECT_LUA_000036")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000036)
			end
	end
	
	
	local Check_Heilong  = CheckItem_Heilong ( ATKER )
	if Check_Heilong == 1 then
			local Percentage = Percentage_Random ( 0.3 )
			if Percentage == 1 then
				  dmg =  dmg*3
				CALCULATE_SKILLEFFECT_LUA_000037 = GetResString("CALCULATE_SKILLEFFECT_LUA_000037")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000037)
			end
	end
	if IsPlayer ( DEFER ) == 1 and IsPlayer ( ATKER ) == 1 then
			local Lv_Check = ReCheck_PK_Lv ( ATKER ,DEFER )
			local Ran = math.min ( 90 , math.max ( 1 ,( 30 + Lv_Check * 2 )))
			local map_name_ATKER = GetChaMapName ( ATKER )
			local map_name_DEFER = GetChaMapName ( DEFER )
			local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
			local SwordLv = GetSkillLv (ATKER,67)
				if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
					Ran = Ran*(1+SwordLv*0.1)
			--		Notice("Ran="..Ran)
				end
				local Check_wumian  = CheckItem_Wumian ( ATKER )
			if Check_wumian == 1 then
				Ran = math.random ( 80 , 100)
				CALCULATE_SKILLEFFECT_LUA_000038 = GetResString("CALCULATE_SKILLEFFECT_LUA_000038")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000038..Ran)
			end
			local Check_Heilong  = CheckItem_Heilong ( ATKER )
			if Check_Heilong == 1 then
			local Percentage = Percentage_Random ( 0.5 )
			if Percentage == 1 then
				  Ran =  Ran*1.5
				CALCULATE_SKILLEFFECT_LUA_000039 = GetResString("CALCULATE_SKILLEFFECT_LUA_000039")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000039)
			end
		
			
	end
			local Dmg_Max = math.floor( dmg * (2/3) )
			local Dmg_Min = math.floor( dmg / 8 )
			dmg = ReCheck_Skill_Dmg ( Dmg_Max , Dmg_Min , Ran )
			if dmg == Dmg_Min then
				CALCULATE_SKILLEFFECT_LUA_000040 = GetResString("CALCULATE_SKILLEFFECT_LUA_000040")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000040 )
			end
	end
	Hp_Endure_Dmg ( DEFER , dmg )  
	if IsPlayer(DEFER) == 1 and IsPlayer(ATKER) == 1 then
		CALCULATE_SKILLEFFECT_LUA_000041 = GetResString("CALCULATE_SKILLEFFECT_LUA_000041")
		SkillLog(ATKER,DEFER,dmg,CALCULATE_SKILLEFFECT_LUA_000041,sklv)
	end
		--LG( "Swzq", "����֮ȭ���ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" )
	local statelv = sklv 
	local statetime = 1    
	local Check_Heilong  = CheckItem_Heilong ( ATKER )
	if Check_Heilong == 1 then
			local Percentage = Percentage_Random ( 0.5 )
			if Percentage == 1 then
				  statetime =  statetime*3
				CALCULATE_SKILLEFFECT_LUA_000042 = GetResString("CALCULATE_SKILLEFFECT_LUA_000042")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000042)
			end
	end
	local hp_defer = Hp ( DEFER ) 
	AddState ( ATKER , DEFER , STATE_XY , statelv , statetime )
-----------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
		
end 

function State_Xy_Add ( role , statelv )

end

function State_Xy_Rem ( role , statelv )

end



--���ܸ��������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Fh ( sklv )										--����"����"��sp���Ĺ�ʽ
   local sp_reduce = 50   
	return sp_reduce 
end 

function SkillCooldown_Fh( sklv )
	local Cooldown = 60000 - sklv * 1500
	return Cooldown
end

function Skill_Fh_Begin ( role , sklv ) 
	local map_name_ATKER = GetChaMapName ( role )
	if map_name_ATKER == "garner2" then
			CALCULATE_SKILLEFFECT_LUA_000043 = GetResString("CALCULATE_SKILLEFFECT_LUA_000043")
			SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000043 )
	SkillUnable(role)   
		end
	
	local item_count = CheckBagItem ( role , ITEM_RELIFE ) 
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , ITEM_RELIFE , 1 ) 
end 


function Skill_Fh_End ( ATKER , DEFER , sklv ) 
	local ChaName = GetChaDefaultName ( ATKER )
--	SystemNotice ( role , "aaaaa" ) 
	CALCULATE_SKILLEFFECT_LUA_000045 = GetResString("CALCULATE_SKILLEFFECT_LUA_000045")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	SetRelive ( ATKER , DEFER ,  sklv , CALCULATE_EXP_AND_LEVEL_LUA_000040..ChaName..CALCULATE_SKILLEFFECT_LUA_000045 ) 
--	local mxhp = GetChaAttr(DEFER,ATTR_MXHP)
--	local hp �� mxhp * 0.05 * sklv
--	SetCharaAttr(hp, DEFER, ATTR_HP) 
-----������״̬
	CheckAttackState1( ATKER , DEFER )
end 


--����----------------------------------------------
function SkillSp_BingX ( sklv )										--����"���ܱ�������"��sp���Ĺ�ʽ
   local sp_reduce = 40 + sklv * 4 
	return sp_reduce 
end 

function SkillCooldown_BingX( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_BingX_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_BingX ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_BingX_End ( ATKER , DEFER , sklv ) 
	local i = CheckBagItem( ATKER , 3463 )
	local ii = CheckBagItem( ATKER , 6465 )
	if i <= 0 and ii<=0 then
		CALCULATE_SKILLEFFECT_LUA_000046 = GetResString("CALCULATE_SKILLEFFECT_LUA_000046")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000046)
		return
	end
	if i > 0 and ii <= 0 then
		local j = DelBagItem(ATKER,3463,1)
		if j == 1 then
			local statelv = sklv 
			local statetime =  8 + sklv * 2
			local map_name_ATKER = GetChaMapName ( ATKER )
			local map_name_DEFER = GetChaMapName ( DEFER )
			local sta_atker = Sta(ATKER)
			local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
				if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
					if Can_Pk_Garner2 == 0 then
						 statetime =math.max(8,math.floor(sta_atker/15))+sklv*2
			--			Notice ( "statetime="..statetime)
					end
				end
			AddState ( ATKER , DEFER , STATE_BIW , statelv , statetime )	
		else
			CALCULATE_SKILLEFFECT_LUA_000047 = GetResString("CALCULATE_SKILLEFFECT_LUA_000047")
			LG("Skill_Item",CALCULATE_SKILLEFFECT_LUA_000047)
		end
	elseif   ii > 0 then 
		local jj = DelBagItem(ATKER,6465,1)
		if jj == 1 then
			local statelv = sklv 
			local statetime =  8 + sklv * 2
			local map_name_ATKER = GetChaMapName ( ATKER )
			local map_name_DEFER = GetChaMapName ( DEFER )
			local sta_atker = Sta(ATKER)
			local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
				if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
					if Can_Pk_Garner2 == 0 then
						 statetime =math.max(8,math.floor(sta_atker/15))+sklv*2
			--			Notice ( "statetime="..statetime)
					end
				end
			AddState ( ATKER , DEFER , STATE_BIW , statelv , statetime )	
		else
			CALCULATE_SKILLEFFECT_LUA_000047 = GetResString("CALCULATE_SKILLEFFECT_LUA_000047")
			LG("Skill_Item",CALCULATE_SKILLEFFECT_LUA_000047)
		end
	 end
end







function Skill_BingX1_Begin ( role ) 
--	SystemNotice ( role , "innnnn" ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local valentinesring = CheckBagItem ( role , 2520 ) 
	local item_count1 = CheckBagItem ( role , 6465 ) 
	local item_count2 = CheckBagItem ( role , 3463 ) 
	if valentinesring == 1 then
		SkillUnable(role) 	
		CALCULATE_SKILLEFFECT_LUA_000048 = GetResString("CALCULATE_SKILLEFFECT_LUA_000048")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000048 ) 
		return 0
	elseif item_count1 > 0 then  
		RemoveChaItem( role , 6465 , 1 , 0 , -1 , 2 , 1 ) 
		return 0	
	elseif item_count2 >0 then
		RemoveChaItem( role , 3463 , 1 , 0 , -1 , 2 , 1 ) 
		return 0			
	else
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000049 = GetResString("CALCULATE_SKILLEFFECT_LUA_000049")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000049 ) 
		return 0		
	end 
end 

function Skill_BingX1_End ( ATKER , DEFER  ) 

	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local statetime = 8
	local statelv = 10 
	AddState ( ATKER , DEFER , STATE_BIW , statelv , statetime )


end


function Skill_BingX2_Begin ( role ) 
--	SystemNotice ( role , "innnnn" ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local valentinesring = CheckBagItem ( role , 2520 ) 
	local item_count1 = CheckBagItem ( role , 6465 ) 
	local item_count2 = CheckBagItem ( role , 3463 ) 
	if valentinesring == 1 then
		SkillUnable(role) 	
		CALCULATE_SKILLEFFECT_LUA_000048 = GetResString("CALCULATE_SKILLEFFECT_LUA_000048")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000048 ) 
		return 0
	elseif item_count1 > 0 then  
		RemoveChaItem( role , 6465 , 1 , 0 , -1 , 2 , 1 ) 
		return 0	
	elseif item_count2 >0 then
		RemoveChaItem( role , 3463 , 1 , 0 , -1 , 2 , 1 ) 
		return 0			
	else
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000049 = GetResString("CALCULATE_SKILLEFFECT_LUA_000049")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000049 ) 
		return 0		
	end 
end 

function Skill_BingX2_End ( ATKER , DEFER  ) 

	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local statetime = 3
	local statelv = 10 
	AddState ( ATKER , DEFER , STATE_BIW , statelv , statetime )


end


--����ʯ��Ƥ������������������������������������������������������������������������������������������������������������������������������������������


function SkillSp_Shpf ( sklv )										--����"����ʯ��Ƥ��"��sp���Ĺ�ʽ
   local sp_reduce = 40 + sklv * 4 
	return sp_reduce 
end 

function SkillCooldown_Shpf( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_Shpf_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Shpf ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Shpf_End ( ATKER , DEFER , sklv ) 
 
	local statelv = sklv 
	local statetime =  180    
	AddState ( ATKER , DEFER , STATE_SHPF , statelv , statetime ) 
	--LG("skill_Shpf", "function Skill_Def_Shpf : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
-----������״̬
	CheckAttackState1( ATKER , DEFER )		
end 


function State_Shpf_Add ( role , statelv ) 
	--LG("state", "function State_Shpf_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 
	local def_dif = 10 + statelv * 4  
	local def = DefSb(role) + def_dif 
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end 



function State_Shpf_Rem ( role , statelv ) 
--	LG("state", "function State_Shpf_Rem : " ,"statelv = " , statelv , " role = ", role, "\n" ) 
	local def_dif = 10 + statelv * 4 
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 


----����ħ���߻�---------------------------------------------------------------

function SkillSp_Mlch ( sklv )										
   local sp_reduce = 40 + sklv * 4 
	return sp_reduce 
end 

function SkillCooldown_Mlch( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_Mlch_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Mlch ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Mlch_End ( ATKER , DEFER , sklv ) 
	local i = CheckBagItem( ATKER , 3462 )
	local ii = CheckBagItem( ATKER , 6464 )
	if i <= 0 and ii <=0 then
		CALCULATE_SKILLEFFECT_LUA_000050 = GetResString("CALCULATE_SKILLEFFECT_LUA_000050")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000050)
		return
	end
	local b = ( sklv - 1 ) * 0.05
	local a = Percentage_Random ( b )
	local j = 0
	local jj = 0
	if  i>0 and ii <= 0 then
		if a == 0 then
			j = DelBagItem(ATKER,3462,1)
		elseif a == 1 then
			j = 1
			CALCULATE_SKILLEFFECT_LUA_000051 = GetResString("CALCULATE_SKILLEFFECT_LUA_000051")
			SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000051 )
		end
		if j == 1  then
			local statelv = sklv 
			local statetime =  90 + 90 * sklv   
			AddState ( ATKER , DEFER , STATE_MLCH , statelv , statetime ) 	
		else
			CALCULATE_SKILLEFFECT_LUA_000052 = GetResString("CALCULATE_SKILLEFFECT_LUA_000052")
			LG("Skill_Item",CALCULATE_SKILLEFFECT_LUA_000052)
		end
	elseif ii > 0 then
		if a == 0 then
			jj = DelBagItem(ATKER,6464,1)
		elseif a == 1 then
			jj = 1
			CALCULATE_SKILLEFFECT_LUA_000051 = GetResString("CALCULATE_SKILLEFFECT_LUA_000051")
			SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000051 )
		end
		if jj == 1  then
			local statelv = sklv 
			local statetime =  90 + 90 * sklv   
			AddState ( ATKER , DEFER , STATE_MLCH , statelv , statetime ) 	
		else
			CALCULATE_SKILLEFFECT_LUA_000052 = GetResString("CALCULATE_SKILLEFFECT_LUA_000052")
			LG("Skill_Item",CALCULATE_SKILLEFFECT_LUA_000052)
		end	
	end

end 


function State_Mlch_Add ( role , statelv ) 
end 



function State_Mlch_Rem ( role , statelv ) 
end

function Cuihua_Mofa ( dmg , statelv ) 
	
		local dmg_fin = math.floor ( dmg * ( 1.4 + statelv * 0.02 ) + statelv * 30 ) 
		return dmg_fin 
	 


end 
 

--���ܸ�����־����������������������������������������������������������������������������������������������������������������������������������������


function SkillSp_Gtyz ( sklv )										--����"���ܸ�����־"��sp���Ĺ�ʽ
   local sp_reduce = 15  
	return sp_reduce 
end 

function SkillCooldown_Gtyz( sklv )
	local Cooldown = 15000
	return Cooldown
end

function Skill_Gtyz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Gtyz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Gtyz_End ( ATKER , DEFER , sklv ) 
 
	local statelv = sklv 
	local statetime =  15    
	AddState ( ATKER , DEFER , STATE_GTYZ , statelv , statetime ) 
	--LG("skill_Gtyz", "function Skill_Def_Gtyz : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
-----������״̬
	CheckAttackState1( ATKER , DEFER )	
end 


function State_Gtyz_Add ( role , statelv ) 
	--LG("state", "function State_GTYZ_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 
	local def_dif = statelv * 3
	local def = DefSb(role) + def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end 



function State_Gtyz_Rem ( role , statelv ) 
--	LG("state", "function State_Gtyz_Rem : " ,"statelv = " , statelv , " role = ", role, "\n" ) 
	local def_dif = statelv * 3
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 




--�����Ƽס���������������������������������������������������������������������������������������������������������������������������������������������������


function SkillSp_Pj ( sklv )										--����"�����Ƽ�"��sp���Ĺ�ʽ
   local sp_reduce = 25  
	return sp_reduce 
end 

function SkillCooldown_Pj( sklv )
	local Cooldown = 25000
	return Cooldown
end

function Skill_Pj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Pj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Pj_End ( ATKER , DEFER , sklv ) 
		local statelv = sklv 
		local statetime =  15    
		local map_name_ATKER = GetChaMapName ( ATKER )
		local map_name_DEFER = GetChaMapName ( DEFER )
		local agi_atker = Agi(ATKER)
		local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0  then
				statetime = agi_atker/10
				if statetime<1 then
					statetime =1
		--		Notice ( "statetime="..statetime)
				end
			end
		end
		AddState ( ATKER , DEFER , STATE_PJ , statelv , statetime ) 
		--LG("skill_Pj", "function Skill_Def_Pj : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
		Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 

		--LG( "sk_pj", "�Ƽ׼��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
---------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
		
end 

function State_Pj_Add ( role , statelv ) 
	--LG("state", "function State_Pj_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 
	local def_dif = statelv * 4
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end 



function State_Pj_Rem ( role , statelv ) 
--	LG("state", "function State_Pj_Rem : " ,"statelv = " , statelv , " role = ", role, "\n" ) 
	local def_dif = statelv * 4
	local def = DefSb(role) + def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 

------------------------�����Ƽ�
function State_JLPj_Add ( role , statelv ) 
	--LG("state", "function State_Pj_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 
	local def_dif = statelv * 60
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end 

function State_JLPj_Rem ( role , statelv ) 
--	LG("state", "function State_Pj_Rem : " ,"statelv = " , statelv , " role = ", role, "\n" ) 
	local def_dif = statelv * 60
	local def = DefSb(role) + def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 
--���ܴ�ɱ����������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Bc ( sklv )										--����"��ɱ"��sp���Ĺ�ʽ
	local sp_reduce = 15 + sklv * 2  
	return sp_reduce 
end 

function SkillCooldown_Bc( sklv )
	local Cooldown = 60000
	return Cooldown
end

function Skill_Bc_Begin ( role , sklv )								--���ܡ���ɱ����ʩ�Ž׶�
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Bc ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Bc_End ( ATKER , DEFER , sklv )									--���ܡ���ɱ����Ч���׶�
	local atk_rad = 1+ sklv * 0.05
	local atk_dire = GetObjDire ( ATKER ) 
	local def_dire = GetObjDire ( DEFER ) 
	dif_dire = atk_dire - def_dire 
	if math.abs(dif_dire) < 90 or math.abs(dif_dire) > 180 then 
		hpdmg = MxatkIb(role) * sklv * 0.3 
	else
		hpdmg = Atk_Raise ( atk_rad , ATKER , DEFER ) 
	end
	Hp_Endure_Dmg ( DEFER , hpdmg ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����

end 

--���ܹ���ն����������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Guz ( sklv )										--����"����ն"��sp���Ĺ�ʽ
	local sp_reduce = 20 + sklv * 3  
	return sp_reduce 
end 

function SkillCooldown_Guz( sklv )
	local Cooldown = 30000
	return Cooldown
end

function Skill_Guz_Begin ( role , sklv )								--���ܡ�����ն����ʩ�Ž׶�
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Guz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 

end 

function Skill_Guz_End ( ATKER , DEFER , sklv )									--���ܡ�����ն����Ч���׶�
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000053 = GetResString("CALCULATE_SKILLEFFECT_LUA_000053")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000053 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000054 = GetResString("CALCULATE_SKILLEFFECT_LUA_000054")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000054 ) 
		return 
	end 
	local a = 1 
	local hpdmg = ( 1 +  sklv * 0.1 ) * Atk_Dmg( ATKER , DEFER )  
	local statelv = sklv 
	local statetime = 3 + math.floor ( sklv * 0.5 ) 
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local agi_atker = Agi(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if  map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then
				statetime = statetime*agi_atker/200
				--Notice ( "statetime="..statetime)
			end
		end
	local atk_dire = GetObjDire ( ATKER ) 
	local def_dire = GetObjDire ( DEFER ) 
	dif_dire = atk_dire - def_dire 
	if math.abs(dif_dire) < 90 or math.abs(dif_dire) > 180 then 
		statetime = statetime * 2  
	end 
	local hp_defer =Mxhp ( DEFER ) 
	if hp_defer >= 100000 then 
		a = Percentage_Random ( 0.8 ) 
		statetime = math.floor ( statetime / 2 ) + 1 
	end 
	local Check_Heilong  = CheckItem_Heilong ( ATKER )
	if Check_Heilong == 1 then
			local Percentage = Percentage_Random ( 0.5 )
			if Percentage == 1 then
				 statetime = statetime * 2
				CALCULATE_FUNCTIONS_LUA_000004 = GetResString("CALCULATE_FUNCTIONS_LUA_000004")
				SystemNotice ( ATKER , CALCULATE_FUNCTIONS_LUA_000004)
			end
	end

	local Check_namei  = CheckItem_namei ( ATKER )
	if Check_namei ==1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				 statetime = statetime + 5
				CALCULATE_SKILLEFFECT_LUA_000055 = GetResString("CALCULATE_SKILLEFFECT_LUA_000055")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000055)
			end
	end
	
	local Check_lufei  = CheckItem_lufei ( ATKER )
	if Check_lufei ==1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				 statetime = statetime + 5
				CALCULATE_SKILLEFFECT_LUA_000056 = GetResString("CALCULATE_SKILLEFFECT_LUA_000056")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000056)
			end
	end
	if  a == 1 then
		----bossʹ�ü��ܴ���
		if GetChaTypeID( ATKER ) == 979 then
			statetime = 8
		end

	if GetChaAIType( DEFER ) >= 21 then    --21����ΪBossAI�������Boss����boss��ͬ���趨���Ա���״̬�Ĵ���
		if BOSSXYSJ[GetChaTypeID( DEFER )] == 0 then
			CALCULATE_SKILLEFFECT_LUA_000028 = GetResString("CALCULATE_SKILLEFFECT_LUA_000028")
			Notice (CALCULATE_SKILLEFFECT_LUA_000028)
			return
		else
			BOSSXYSJ[GetChaTypeID( DEFER )] = BOSSXYSJ[GetChaTypeID( DEFER )] -1
		end
	end
		----bossʹ�ü��ܴ�������
		Hp_Endure_Dmg ( DEFER , hpdmg ) 
		AddState( ATKER , DEFER , STATE_XY, statelv , statetime ) 
	else 
		SetSus( DEFER , 0 ) 
	end 
	Check_Ys_Rem ( ATKER ,DEFER )						--�ж��Ƿ�����
-----������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )	

end 
--���ܶ�����������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Dj ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end

function SkillCooldown_Dj( sklv )
	local Cooldown = 25000
	return Cooldown
end

function Skill_Dj_Begin ( role , sklv ) 
	--LG( "skill_dj", "enter function Skill_Atk_Dj : " , "\n" ) 
	--LG("skill_dj", "function Skill_Atk_Dj : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Dj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Dj_End ( ATKER , DEFER , sklv ) 
	--LG( "skill_db", "enter function Skill_Def_Dj : " , "\n" ) 
	local statelv = sklv 
	local statetime =  11 + sklv * 1    
	AddState ( ATKER , DEFER , STATE_DJ , statelv , statetime ) 
	--LG("skill_dj", "function Skill_Def_Dj : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
----------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
		
end 


function State_Dj_Add ( role , statelv ) 
	--LG("state_Dj" , "function State_Dj_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local hpdmg = 10 + statelv * 2   
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role)  
end 

function State_Dj_Rem ( role , statelv ) 
	--LG("state_Dj" , "function State_Dj_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
end 

--���ܶ��� ��������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Db ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end

function SkillCooldown_Db( sklv )
	local Cooldown = 20000
	return Cooldown
end

function Skill_Db_Begin ( role , sklv ) 
	--LG( "skill_db", "enter function Skill_Atk_Db : " , "\n" ) 
	--LG("skill_db", "function Skill_Atk_Db : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Db ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Db_End ( ATKER , DEFER , sklv ) 
	--LG( "skill_db", "enter function Skill_Def_Db : " , "\n" ) 
	local statelv = sklv 
	local statetime =  5 + sklv * 4    
	AddState ( ATKER , DEFER , STATE_ZD , statelv , statetime ) 
	--LG("skill_db", "function Skill_Def_Db : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
-----������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
end 


function State_Zd_Add ( role , statelv ) 
	--LG("state_Zd" , "function State_Zd_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local hpdmg = 10 + statelv * 2  
	local map_name_ATKER = GetChaMapName ( role )
	local agi_atker = Agi(role)
	local Can_Pk_Garner2 = Is_NormalMonster (role)
		if map_name_ATKER == "garner2"  then 
			if Can_Pk_Garner2 == 0 then
			hpdmg = math.max(5,320)
	--		Notice ( "hpdmg="..hpdmg)
			end
		
		end
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role)  
end 

function State_Zd_Rem ( role , statelv ) 
	--LG("state_Zd" , "function State_Zd_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
end 

--���������������������������������������������������������������������������������������������������������������������������������������������������������������������������
--function SkillSp_Mb ( sklv )										
--	local sp_reduce = 10 
--	return sp_reduce 
--end

--function Skill_Mb_Begin ( role , sklv ) 
--	LG( "skill_mb", "enter function Skill_Atk_Mb : " , "\n" ) 
--	LG("skill_mb", "function Skill_Atk_Mb : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
--	local sp = Sp(role) 
--	local sp_reduce = SkillSp_Mb ( sklv ) 
--  	if sp - sp_reduce < 0 then 
--		SkillUnable(role)   
--		return 
--	end 
--	Sp_Red (role , sp_reduce ) 
--end 
--
--  function Skill_Mb_End ( ATKER , DEFER , sklv ) 
--	LG( "skill_mb", "enter function Skill_Def_Mb : " , "\n" ) 
--	local statelv = sklv 
--	local statetime = 5  
--	AddState ( ATKER , DEFER , STATE_MB , statelv , statetime ) 
--	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
--  	LG("skill_mb", "function Skill_Def_Mb : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
--end 
--
--

function SkillCooldown_Mb( sklv )
	local Cooldown = 20000
	return Cooldown
end

function State_Mb_Add ( role , statelv ) 
--	LG("state_Mb" , "function State_Mb_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local aspdsa_dif = (-1) * (  0.1 + statelv * 0.03   ) 
	local mspdsa_dif = (-1) * (  0.2 +statelv * 0.03 ) 

	local aspdsa = math.floor ( ( AspdSa( role ) + aspdsa_dif ) * ATTR_RADIX )  
	local mspdsa = math.floor ( ( MspdSa( role ) + mspdsa_dif ) * ATTR_RADIX  ) 

  	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 

	ALLExAttrSet(role)  
end 



function State_Mb_Rem ( role , statelv ) 
--	LG("state_Mb" , "function State_Mb_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local aspdsa_dif = (-1) * (  0.1 + statelv * 0.03   ) 
	local mspdsa_dif = (-1) * (  0.2 +statelv * 0.03 ) 
	local aspdsa = math.floor ( ( AspdSa( role ) - aspdsa_dif ) * ATTR_RADIX )  
	local mspdsa = math.floor ( ( MspdSa( role ) - mspdsa_dif ) * ATTR_RADIX  ) 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 


--����쫷硪����������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Jf ( sklv )										
	local sp_reduce = 25 + sklv * 2   
	return sp_reduce 
end 

function SkillCooldown_Jf( sklv )
	local Cooldown = 12000
	return Cooldown
end

function SkillEnergy_Jf ( sklv )										
	local energy_reduce = math.floor ( 1 + sklv * 0.25 )    
	return energy_reduce 
end 

function Skill_Jf_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Jf ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Jf_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = math.floor ( 3 + sklv * 0.5 ) 
	local a = 1 
	local hp_defer = Hp ( DEFER ) 
	local MxHp_defer = Mxhp ( DEFER )
	
	if MxHp_defer >= 100000 then
		SetSus( DEFER , 0 )
		return
	end

	if hp_defer >= 50000 then 
		a = Percentage_Random ( 0.2 ) 
		statetime = math.floor ( statetime / 2 ) + 1 
	end 
	if  a == 1 then
	----bossʹ�ü��ܴ���
	if GetChaTypeID( ATKER ) == 986 then
		statetime = 12
		statelv = 10
	end
	----bossʹ�ü��ܴ�������
		AddState ( ATKER , DEFER , STATE_JF , statelv , statetime ) 
	else 
		SetSus( DEFER , 0 ) 
	end 
----------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
end 

function State_Jf_Add ( role , statelv ) 
end 

function State_jf_Rem ( role , statelv ) 
end 



--�����׻�������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Lj ( sklv )										
	local sp_reduce = 25 + sklv * 2   
	return sp_reduce 
end

function SkillCooldown_Lj( sklv )
	local Cooldown = 8400 - sklv * 400
	return Cooldown
end

function SkillEnergy_Lj ( sklv )										
	local energy_reduce = math.floor ( 3 + sklv * 0.5 )    
	return energy_reduce 
end 

function Skill_Lj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Lj ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Lj_End ( ATKER , DEFER , sklv ) 
	local statelv = 2  
	local statetime = 3 
	local atk_role = TurnToCha ( ATKER ) 
	local def_role = TurnToCha ( DEFER ) 
	local sta_atk= Sta ( ATKER ) 
	local sta_def = Sta ( DEFER )
	local Lv = Lv( ATKER )
	local AddStateLv = 0
	AddStateLv = GetChaStateLv ( ATKER , STATE_MLCH )
	
	local dmg = math.floor (( 80 + sklv*10 +sta_atk * 6 ) + 3 * Lv)*1.15

	local map_name_DEFER = GetChaMapName ( DEFER )
	local agi_atker = Agi(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then
			
			dmg = math.floor(MAGIC_Atk_Dmg(ATKER,DEFER)*math.pow(sklv,1/2))

			end
		end

	local Check_Heilong  = CheckItem_Heilong ( ATKER )
	if Check_Heilong == 1 then
			local Percentage = Percentage_Random ( 0.8 )
			if Percentage == 1 then
				  dmg =  dmg*1.5 
				CALCULATE_SKILLEFFECT_LUA_000057 = GetResString("CALCULATE_SKILLEFFECT_LUA_000057")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000057)
			end
	end
	
	local Check_namei  = CheckItem_namei ( ATKER )
	if Check_namei == 1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				  dmg =  dmg*3 
				CALCULATE_SKILLEFFECT_LUA_000058 = GetResString("CALCULATE_SKILLEFFECT_LUA_000058")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000058)
			end
	end
	
	local Check_lufei  = CheckItem_lufei ( ATKER )
	if Check_lufei == 1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				  dmg =  dmg*3 
				CALCULATE_SKILLEFFECT_LUA_000059 = GetResString("CALCULATE_SKILLEFFECT_LUA_000059")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000059)
			end
	end
	
	local dmg_fin = Cuihua_Mofa ( dmg , AddStateLv )
	local dmg_ElfSkill = ElfSkill_MagicAtk ( dmg , ATKER )
	dmg_fin = dmg_fin + dmg_ElfSkill
	local ZSExp = GetChaAttr( ATKER , ATTR_CSAILEXP )
	if ZSExp > 0 and ZSExp < 100 then
		dmg_fin = dmg_fin * 1.055
	end
	if ZSExp >= 100 and ZSExp < 12100 then
		dmg_fin = dmg_fin * ( 1.05 + math.floor( math.pow( (ZSExp / 100) , 0.5 )) * 0.005)
	end
	AddState ( ATKER , DEFER , STATE_MB , statelv , statetime ) 
	Hp_Endure_Dmg ( DEFER , dmg_fin ) 
	if IsPlayer(DEFER) == 1 and IsPlayer(ATKER) == 1 then
		CALCULATE_SKILLEFFECT_LUA_000060 = GetResString("CALCULATE_SKILLEFFECT_LUA_000060")
		SkillLog(ATKER,DEFER,dmg_fin,CALCULATE_SKILLEFFECT_LUA_000060,sklv)
	end	
----------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
end 







--�����Ե��̡���������������������������������������������������������������������������������������������������������������������������������������������������


function SkillSp_Ldc ( sklv )										--����"�Ե���"��sp���Ĺ�ʽ
	local sp_reduce = 10  
	return sp_reduce 
end 

function SkillCooldown_Ldc( sklv )
	local Cooldown = 30000
	return Cooldown
end

function Skill_Ldc_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Ldc ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Ldc_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000061 = GetResString("CALCULATE_SKILLEFFECT_LUA_000061")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000061 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000062 = GetResString("CALCULATE_SKILLEFFECT_LUA_000062")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000062 ) 
		return 
	end 
		dmg = ( 2 +  sklv * 0.2 ) * Atk_Dmg ( ATKER ,DEFER ) 
		Hp_Endure_Dmg ( DEFER , dmg )  

end 

--����С����������������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Xzy ( sklv )							
	local sp_reduce = 30 + sklv * 4    
	return sp_reduce 
end

function SkillCooldown_Xzy( sklv ) 
	local Cooldown = 7000 - sklv * 300 
	return Cooldown 
end

function Skill_Xzy_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Xzy ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Xzy_End ( ATKER , DEFER , sklv ) 
	local sta = Sta( ATKER ) 
	local exp = Exp( ATKER ) 
	local hpdmg = ( -1 ) * math.floor ( 50 + 15 * sklv + sta * 7 )*1.1 
		local Check_namei  = CheckItem_namei ( ATKER )
		if Check_namei == 1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				  hpdmg =  hpdmg*2 
				CALCULATE_SKILLEFFECT_LUA_000063 = GetResString("CALCULATE_SKILLEFFECT_LUA_000063")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000063)
			end
		end
		
		local Check_lufei  = CheckItem_lufei ( ATKER )
		if Check_lufei == 1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				  hpdmg =  hpdmg*2 
				CALCULATE_SKILLEFFECT_LUA_000064 = GetResString("CALCULATE_SKILLEFFECT_LUA_000064")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000064)
			end
	end


	local mxhp_def = Mxhp( DEFER ) 
	local hp_def = Hp( DEFER ) 
	local hp_recover = math.max( math.min ( ( mxhp_def - hp_def ) , (-1) * hpdmg ) , 0 )
	local exp_add = hp_recover / 8 
	local Lv = Lv( ATKER )
		if Lv >= 80 then
			exp_add = exp_add / 50
		end
	local rolemode_defer = IsPlayer ( DEFER ) 
	local ChaList = {}
	local i = 0
	local Hate = 0
	local role = ATKER
	local HateNum = 3
	local HateAddNum = 0
	if rolemode_defer == 1 and DEFER ~= ATKER then 
		exp = exp + exp_add 
		SetCharaAttr ( exp , ATKER , ATTR_CEXP )  
	end 
	Hp_Endure_Dmg ( DEFER , hpdmg ) 
	ChaList[1] , ChaList[2] , ChaList[3] , ChaList[4] , ChaList[5] , ChaList[6] , ChaList[7] , ChaList[8] , ChaList[9] , ChaList[10] , ChaList[11] , ChaList[12] = GetChaSetByRange ( DEFER , 0 ,0 ,800 , 0)
	Hate = math.floor ( hpdmg / -2 )
	for i = 1 , 12 , 1 do
		if ChaList[i] ~= nil then
			role = GetChaTarget ( ChaList[i] )
			if role == DEFER then
				if HateAddNum < HateNum then
					AddHate ( ChaList[i] , ATKER , Hate )
					HateAddNum = HateAddNum + 1
				end

			end
		end
	end
---------------������״̬
	CheckAttackState1( ATKER , DEFER )		
		
end 


--���ܻظ���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Hfs ( sklv )										--����"�ظ���"��sp���Ĺ�ʽ
	local sp_reduce = 20    
	return sp_reduce 
end 

function SkillCooldown_Hfs( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_Hfs_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Hfs ( sklv ) 
	local hp_recover = sklv * 50 + 100 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	local hp = Hp ( role ) + hp_recover 
	SetCharaAttr ( hp , role , ATTR_HP ) 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Hfs_End ( ATKER , DEFER , sklv ) 
		Rem_State_Unnormal ( DEFER ) 
		--LG( "Hfs", "�ظ������ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
-----������״̬
	CheckAttackState1( ATKER , DEFER )
		
		
end 


--���������ײ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Xlcz ( sklv )										--����"�����ײ"��sp���Ĺ�ʽ
	local sp_reduce = 30 + sklv * 2   
	return sp_reduce 
end 

function SkillCooldown_Xlcz( sklv ) 
	local Cooldown = 6000 - sklv * 300
	return Cooldown
end

function Skill_Xlcz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Xlcz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Xlcz_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000065 = GetResString("CALCULATE_SKILLEFFECT_LUA_000065")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000065 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000066 = GetResString("CALCULATE_SKILLEFFECT_LUA_000066")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000066 ) 
		return 
	end 
--	local atkdmg = Atk_Dmg ( ATKER , DEFER )
	local lv_atker = Lv ( TurnToCha ( ATKER ) ) 
	local lv_defer = Lv ( TurnToCha ( DEFER ) ) 
	local sta_atker = Sta(ATKER) 
	local sta_defer = Sta(DEFER) 
	local lv_dif = math.max ( ( - 1 ) * 10 , math.min ( 10 , lv_atker - lv_defer ) ) 
	local AddStateLv = 0
	AddStateLv = GetChaStateLv ( ATKER , STATE_MLCH )

	hpdmg = math.floor (( 10 + sta_atker * 2 ) * ( 1 + sklv * 0.25 ) * ( 1 +  lv_dif * 0.025 ))*1.1
		local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local agi_atker = Agi(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then
			
		local dmg = MAGIC_Atk_Dmg(ATKER,DEFER)

		hpdmg = math.floor (dmg * ( 1 + sklv * 0.1 ) )
	--			Notice ( "statetime="..statetime)
			end
		end
	local dmg_fin = Cuihua_Mofa ( hpdmg ,AddStateLv )
	local dmg_ElfSkill = ElfSkill_MagicAtk ( hpdmg , ATKER )
	dmg_fin = dmg_fin + dmg_ElfSkill
	local ZSExp = GetChaAttr( ATKER , ATTR_CSAILEXP )
	if ZSExp > 0 and ZSExp < 100 then
		dmg_fin = dmg_fin * 1.055
	end
	if ZSExp >= 100 and ZSExp < 12100 then
		dmg_fin = dmg_fin * ( 1.05 + math.floor( math.pow( (ZSExp / 100) , 0.5 )) * 0.005)
	end
	Hp_Endure_Dmg ( DEFER, dmg_fin )  
	if IsPlayer(DEFER) == 1 and IsPlayer(ATKER) == 1 then
		CALCULATE_SKILLEFFECT_LUA_000067 = GetResString("CALCULATE_SKILLEFFECT_LUA_000067")
		SkillLog(ATKER,DEFER,dmg_fin,CALCULATE_SKILLEFFECT_LUA_000067,sklv)
	end
--	LG( "xlcz", "�����ײ���ܵȼ� = " , sklv ,"������sta=", sta ,"��ͨ�����˺�=", atkdmg , "�����˺� = " , dmg , "\n" ) 
----------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
		
end 

function MAGIC_Atk_Dmg(a,b) --[[������ͨ�����Ļ��������˺�]]--

	local job = GetChaAttr(a, ATTR_JOB) --��ְͬҵ���ò�ͬ�����Գɳ���
	local sta_atker = Sta(a) 
	local sta_defer = Sta(b) 
	local atk_mnatk = math.floor (MnatkIb(a) + sta_atker*Magic_rate1[job] +  Magic_rate2[job] * math.pow(math.floor( sta_atker*4/20), 2 ))
	local atk_mxatk = math.floor (MxatkIb(a)  + sta_atker*Magic_rate1[job] + Magic_rate2[job] * math.pow(math.floor( sta_atker*4/20), 2 ))
	local defer_mgic_def = sta_defer * 2  
	local defer_resist = Resist(b)  
	local atker_lv = Lv( a ) 
	local defer_lv = Lv( b ) 
	local lv_dis = atker_lv - defer_lv 
	local lv_eff = 1 
	if math.abs (lv_dis) >= 1 then 
		lv_eff =math.min (  math.max ( 0.5 , 1 + 0.025 * lv_dis ) , 1.5 )  
	end 
		
	local atk = math.random( atk_mnatk , atk_mxatk ) 
	local dmg = Magic_Dmg ( atk, defer_mgic_def , defer_resist )  --[[���������˺�ֵ]]--
	local mndmg = math.floor(  Lv(a) * 0.25 + Mnatk(a) * 0 ) + 1 --[[������С�˺�ֵ]]--
	dmg =math.max(  lv_eff * dmg , mndmg ) 

	return dmg 
end 

function Magic_Dmg (atk, def, resist )					--[[������������]]--
	local magic_atk = atk 
	local magic_def = def 
	local magic_resist = resist 
--	LuaPrint ( " ���������� "..phy_atk.." ��������= "..phy_def.." �����ֿ�= "..phy_resist ) 
--	LuaPrint (\n) 
--	LG ( " �˺�" , "�������� = ", phy_atk, " �������� = " , phy_def, " �����ֿ� = " , phy_resist, "\n" ) 
	dmg = math.floor( (magic_atk   - magic_def ) * (1 - math.min (0.85 , magic_resist/100 )  ))
	return dmg 
end 


	Magic_rate1 = {} 
	Magic_rate2 = {} 

Magic_rate1[	JOB_TYPE_XINSHOU	]=	1
Magic_rate1[	JOB_TYPE_JIANSHI	]=	1
Magic_rate1[	JOB_TYPE_LIEREN	]=	1
Magic_rate1[	JOB_TYPE_SHUISHOU	]=	1
Magic_rate1[	JOB_TYPE_MAOXIANZHE	]=	1.5
Magic_rate1[	JOB_TYPE_QIYUANSHI	]=	1.5
Magic_rate1[	JOB_TYPE_JISHI	]=	1
Magic_rate1[	JOB_TYPE_SHANGREN	]=	1
Magic_rate1[	JOB_TYPE_JUJS	]=	1
Magic_rate1[	JOB_TYPE_SHUANGJS	]=	1
Magic_rate1[	JOB_TYPE_JIANDUNSHI	]=	1
Magic_rate1[	JOB_TYPE_XUNSHOUSHI	]=	1
Magic_rate1[	JOB_TYPE_JUJISHOU	]=	1
Magic_rate1[	JOB_TYPE_SHENGZHIZHE	]=	2
Magic_rate1[	JOB_TYPE_FENGYINSHI	]=	3
Magic_rate1[	JOB_TYPE_CHUANZHANG	]=	1
Magic_rate1[	JOB_TYPE_HANGHAISHI	]=	2
Magic_rate1[	JOB_TYPE_BAOFAHU	]=	1
Magic_rate1[	JOB_TYPE_GONGCHENGSHI	]=	1

Magic_rate2[	JOB_TYPE_XINSHOU	]=	0.4
Magic_rate2[	JOB_TYPE_JIANSHI	]=	0.4
Magic_rate2[	JOB_TYPE_LIEREN	]=	0.4
Magic_rate2[	JOB_TYPE_SHUISHOU	]=	0.4
Magic_rate2[	JOB_TYPE_MAOXIANZHE	]=	0.3
Magic_rate2[	JOB_TYPE_QIYUANSHI	]=	0.3
Magic_rate2[	JOB_TYPE_JISHI	]=	0.4
Magic_rate2[	JOB_TYPE_SHANGREN	]=	0.4
Magic_rate2[	JOB_TYPE_JUJS	]=	0.4
Magic_rate2[	JOB_TYPE_SHUANGJS	]=	0.4
Magic_rate2[	JOB_TYPE_JIANDUNSHI	]=	0.4
Magic_rate2[	JOB_TYPE_XUNSHOUSHI	]=	0.4
Magic_rate2[	JOB_TYPE_JUJISHOU	]=	0.4
Magic_rate2[	JOB_TYPE_SHENGZHIZHE	]=	0.35
Magic_rate2[	JOB_TYPE_FENGYINSHI	]=	0.45
Magic_rate2[	JOB_TYPE_CHUANZHANG	]=	0.4
Magic_rate2[	JOB_TYPE_HANGHAISHI	]=	0.35
Magic_rate2[	JOB_TYPE_BAOFAHU	]=	0.4
Magic_rate2[	JOB_TYPE_GONGCHENGSHI	]=	0.4

--��������֮�𡪡�������������������������������������������������������������������������������������������������������������������������
function SkillSp_Xlzh ( sklv )										
	local sp_reduce = 45  + math.floor ( sklv * 3 )  
	return sp_reduce 
end

function SkillCooldown_Xlzh( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_Xlzh_Begin ( role , sklv ) 
	local sp = Sp( role ) 
	local sp_reduce = SkillSp_Xlzh ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Xlzh_End ( ATKER , DEFER , sklv )  
	local statelv = sklv 
	local statetime = 180 + sklv * 20 
	--LG( "Xlzh", "����֮���ܵȼ� = " , sklv , "\n" ) 
	AddState( ATKER , DEFER , STATE_XLZH, statelv , statetime )
	--LG("skill_Xlzh", "function Skill_Oper_Xlzh: " , "add state Xlzh " , "\n" ) 
-----------������״̬
	CheckAttackState1( ATKER , DEFER )
		
end 

function State_Xlzh_Add ( role , statelv ) 
	--LG("state_xlzh" , "function State_xlzh_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mnatksa_dif =0.1 + 0.01 * statelv 
	local mxatksa_dif =0.1 + 0.01 * statelv
	local mnatksa = math.floor ( (MnatkSa(role) + mnatksa_dif ) * ATTR_RADIX) 
	local mxatksa = math.floor ( (MxatkSa(role) + mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
---------------������״̬
		
		
end 



function State_Xlzh_Rem ( role , statelv ) 
	--LG("state_xlzh" , "function State_xlzh_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mnatksa_dif =0.1 + 0.01 * statelv 
	local mxatksa_dif =0.1 + 0.01 * statelv
	local mnatksa = math.floor ( (MnatkSa(role) - mnatksa_dif ) * ATTR_RADIX) 
	local mxatksa = math.floor ( (MxatkSa(role) - mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
end 

--���ܷ�֮��������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Fzlz ( sklv )										
	local sp_reduce = 40  + sklv * 4
	return sp_reduce 
end

function SkillCooldown_Fzlz( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_Fzlz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Fzlz(sklv)  
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Fzlz_End ( ATKER , DEFER , sklv )  
	local statelv = sklv 
	local statetime = 180 + sklv * 18 
	--LG( "Fzlz", "��֮�������ܵȼ� = " , sklv , "\n" ) 
	----bossʹ�ü��ܴ���
	if GetChaTypeID( ATKER ) == 984 then
		statetime = 360
		statelv = 10
	end
	----bossʹ�ü��ܴ�������

	AddState( ATKER , DEFER , STATE_FZLZ, statelv , statetime )
	--LG("skill_Fzlz", "function Skill_Oper_Fzlz: " , "add state Fzlz " , "\n" ) 
---------------������״̬
	CheckAttackState1( ATKER , DEFER )		
		
end 

function State_Fzlz_Add ( role , statelv ) 
	--LG("state_Fzlz" , "function State_Fzlz_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mspdsa_dif = 0.05 + 0.01 * statelv 
	local aspdsa_dif = 0.05 + 0.01 * statelv 
	local mspdsa = math.floor ( (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX) 
	local aspdsa = math.floor ( (AspdSa(role) + aspdsa_dif ) * ATTR_RADIX)
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)  
end 

function State_Fzlz_Rem ( role , statelv ) 
	--LG("state_fzlz" , "function State_fzlz_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mspdsa_dif =0.05 + 0.01 * statelv 
	local aspdsa_dif = 0.05 + 0.01 * statelv 
	local mspdsa = math.floor ( (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX) 
	local aspdsa = math.floor ( (AspdSa(role) - aspdsa_dif ) * ATTR_RADIX)
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)  
end 

--���ܱ���������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Bdj ( sklv )										--����"������"��sp���Ĺ�ʽ
   local sp_reduce = 15   
	return sp_reduce 
end 

function SkillCooldown_Bdj( sklv )
	local Cooldown = 15000
	return Cooldown
end

function Skill_Bdj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Bdj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Bdj_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000068 = GetResString("CALCULATE_SKILLEFFECT_LUA_000068")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000068 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000069 = GetResString("CALCULATE_SKILLEFFECT_LUA_000069")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000069 ) 
		return 
	end 
	local hpdmg =1.2 * Atk_Dmg ( ATKER , DEFER ) 
	Hp_Endure_Dmg ( DEFER , hpdmg )  
	local statelv = sklv 
	local statetime = 5 
	----bossʹ�ü��ܴ���
	if GetChaTypeID( ATKER ) == 983 then
		statelv = 10
	end
	----bossʹ�ü��ܴ�������
	AddState ( ATKER , DEFER , STATE_BDJ , statelv , statetime ) 
---------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
		
end 

function State_Bdj_Add ( role , statelv ) 
	--LG("state_Bdj" , "function State_Bdj_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mspdsa_dif = 0.2 + statelv * 0.03
	local mspdsa = ( MspdSa(role) - mspdsa_dif ) * ATTR_RADIX  
	SetCharaAttr ( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 

function State_Bdj_Rem ( role , statelv ) 
	--LG("state_Bdj" , "function State_Bdj_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mspdsa_dif = 0.2 + statelv * 0.03
	local mspdsa =( MspdSa(role) + mspdsa_dif ) * ATTR_RADIX  
	SetCharaAttr ( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 


--�����Ⱦѹ�ʽ������������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Tj ( sklv )										
	local sp_reduce = 10 + sklv * 0.5  
	return sp_reduce 
end

function SkillCooldown_Tj( sklv )
	local Cooldown = 8000 - sklv * 200  
	return Cooldown 
end 

function Skill_Tj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Tj ( sklv )
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Tj_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 5 + sklv * 0.5 
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local agi_atker = Agi(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
	--	if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" then
	--		if Can_Pk_Garner2 == 0 then
	--		 statetime =math.max(3,math.floor(agi_atker/20))+sklv*0.5
	--			Notice ( "statetime="..statetime)
	--		end
	--	end
	local hp_defer = Mxhp ( DEFER ) 
	if hp_defer >= 100000 then 
		statetime = math.floor ( statetime / 3 ) + 1 
	end 
 	dmg = ( 1 + sklv * 0.05 ) * Atk_Dmg ( ATKER , DEFER )  
	Hp_Endure_Dmg ( DEFER , dmg )  

----bossʹ�ü��ܴ���

	if GetChaTypeID( ATKER ) == 980 then
		statetime = 5
	end
	if GetChaAIType( DEFER ) >= 21 then    --21����ΪBossAI�������Boss����boss��ͬ���趨���Ա���״̬�Ĵ���
		if BOSSTJSJ[GetChaTypeID( DEFER )] == 0 then
			CALCULATE_SKILLEFFECT_LUA_000028 = GetResString("CALCULATE_SKILLEFFECT_LUA_000028")
			Notice (CALCULATE_SKILLEFFECT_LUA_000028)
			return
		else
			BOSSTJSJ[GetChaTypeID( DEFER )] = BOSSTJSJ[GetChaTypeID( DEFER )] -1
		end
	end

----bossʹ�ü��ܴ�������

	AddState( ATKER , DEFER , STATE_TJ, statelv , statetime ) 
-----------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )	
end 

function State_Tj_Add ( role , statelv ) 
	--LG("state_Tj" , "function State_Tj_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local fleesa_dif = (-1) * 0.2 
	local mspdsa_dif = (-1) * ( 0.5 + 0.025 * statelv ) 
	local fleesa = (FleeSa(role) + fleesa_dif ) * ATTR_RADIX
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( fleesa , role , ATTR_STATEC_FLEE ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 

function State_Tj_Rem ( role , statelv ) 
	--LG("state_tj" , "function State_Tj_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local fleesa_dif = (-1) * 0.2 
	local mspdsa_dif = (-1) * ( 0.5 + 0.025 * statelv ) 
	local fleesa = (FleeSa(role) - fleesa_dif ) * ATTR_RADIX
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( fleesa , role , ATTR_STATEC_FLEE ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 


--�����־ѹ�ʽ������������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Sj ( sklv )										
	local sp_reduce = 25 + sklv * 1   
	return sp_reduce 
end

function SkillCooldown_Sj( sklv )
	local Cooldown = 15000
	return Cooldown
end

function Skill_Sj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Sj ( sklv )
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Sj_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 5 + math.floor ( sklv * 0.5  ) 
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local agi_atker = Agi(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
	--	if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" then
	--		if Can_Pk_Garner2 == 0 then
	--		 statetime =math.max(5,math.floor(agi_atker/20))+sklv
	--			Notice ( "statetime="..statetime)
	--		end
	--	end
	local a = 1 
 	local dmg = math.floor( 100 + sklv * 10  )  
	Hp_Endure_Dmg ( DEFER , dmg )  
	--LG( "Sj", "�־Ѽ��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
	local hp_defer = Mxhp ( DEFER ) 
	if hp_defer >= 100000 then 
		local a = Percentage_Random (1)
		if a == 1 then
			statetime = math.floor ( 3 + sklv * 0.3 ) 
		else
			SetSus( DEFER , 0 )
			CALCULATE_SKILLEFFECT_LUA_000070 = GetResString("CALCULATE_SKILLEFFECT_LUA_000070")
			SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000070 ) 
			return
		end
	end 
----bossʹ�ü��ܴ���
	if GetChaTypeID( ATKER ) == 980 then
		statetime = 5
	end
	if GetChaAIType( DEFER ) >= 21 then    --21����ΪBossAI�������Boss����boss��ͬ���趨���Ա���״̬�Ĵ���
		if BOSSSJSJ[GetChaTypeID( DEFER )] == 0 then
			CALCULATE_SKILLEFFECT_LUA_000028 = GetResString("CALCULATE_SKILLEFFECT_LUA_000028")
			Notice (CALCULATE_SKILLEFFECT_LUA_000028)
			return
		else
			BOSSSJSJ[GetChaTypeID( DEFER )] = BOSSSJSJ[GetChaTypeID( DEFER )] -1
		end
	end
----bossʹ�ü��ܴ�������
	AddState( ATKER , DEFER , STATE_SJ, statelv , statetime ) 
	AddState( ATKER , DEFER , STATE_JNJZ, statelv , statetime ) 
	--LG( "Sj", "�־Ѽ��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
-----------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
		
end 

function State_Sj_Add ( role , statelv ) 
	--LG("state_sj" , "function State_Sj_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mnatksa_dif = (-1) * 0.2 
	local mxatksa_dif = (-1) * 0.2  
	local mnatksa = (MnatkSa(role) + mnatksa_dif ) * ATTR_RADIX
	local mxatksa = (MxatkSa(role) + mxatksa_dif ) * ATTR_RADIX 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
end 

function State_Sj_Rem ( role , statelv ) 
	--LG("state_sj" , "function State_Sj_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mnatksa_dif = (-1) * 0.2 
	local mxatksa_dif = (-1) * 0.2  
	local mnatksa = (MnatkSa(role) - mnatksa_dif ) * ATTR_RADIX 
	local mxatksa = (MxatkSa(role) - mxatksa_dif ) * ATTR_RADIX 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
end 


--���ܱ�ͷ����������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Bt ( sklv )										--����"��ͷ"��sp���Ĺ�ʽ
	local sp_reduce = sklv * 2 + 30  
	return sp_reduce 
end 

function SkillCooldown_Bt( sklv )
	local Cooldown = 25000
	return Cooldown
end

function Skill_Bt_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Bt ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Bt_End ( ATKER , DEFER , sklv ) 
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	local 	dmg = math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.005 * sklv) ) 
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local dex_atker = Dex(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then
				dmg = math.floor ( dex_atker*2 + 30 * sklv +hp * ( 0.05 +0.005 * sklv) ) 
	--			Notice ( "dmg="..dmg)
			end
		end
	if dmg > 2500 then
		dmg = 2500
	end
	local Check_Heilong  = CheckItem_Heilong ( ATKER )
	if Check_Heilong == 1 then
			local Percentage = Percentage_Random ( 0.1 )
			if Percentage == 1 then
				  dmg =  dmg*10 
				CALCULATE_SKILLEFFECT_LUA_000057 = GetResString("CALCULATE_SKILLEFFECT_LUA_000057")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000057)
			end
	end
	
	local Check_namei  = CheckItem_namei ( ATKER )
		if Check_namei == 1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				  dmg =  dmg*10 
				CALCULATE_SKILLEFFECT_LUA_000071 = GetResString("CALCULATE_SKILLEFFECT_LUA_000071")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000071)
			end
	end

	local Check_lufei  = CheckItem_lufei ( ATKER )
		if Check_lufei == 1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				  dmg =  dmg*10 
				CALCULATE_SKILLEFFECT_LUA_000072 = GetResString("CALCULATE_SKILLEFFECT_LUA_000072")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000072)
			end
	end

	hp = hp - dmg 
	SetCharaAttr ( hp , DEFER , ATTR_HP ) 
	if IsPlayer(DEFER) == 1 and IsPlayer(ATKER) == 1 then
		CALCULATE_SKILLEFFECT_LUA_000073 = GetResString("CALCULATE_SKILLEFFECT_LUA_000073")
		SkillLog(ATKER,DEFER,dmg,CALCULATE_SKILLEFFECT_LUA_000073,sklv)
	end	
--------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
		
end 

--������ʹ���ܡ���������������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Tshd ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end

function SkillCooldown_Tshd( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_Tshd_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Tshd ( sklv )	
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Tshd_End ( ATKER , DEFER , sklv )  
	local statelv = sklv 
	local statetime = 30 + sklv * 3  
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local sta_atker = Sta(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (ATKER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then
			 statetime =math.max(30,math.floor(sta_atker/5))+sklv*3
		--		Notice ( "statetime="..statetime)
			end
		end
	----bossʹ�ü��ܴ���
	if GetChaTypeID( ATKER ) == 984 then
		statetime = 360
		statelv = 10
	end
	----bossʹ�ü��ܴ�������
        AddState( ATKER , DEFER , STATE_TSHD, statelv , statetime )
	--LG("skill_Tshd", "function Skill_Oper_Tshd: " , "add state tshd " , "\n" ) 
---------------������״̬
	CheckAttackState1( ATKER , DEFER )	
			
end 

function State_Tshd_Add ( role , statelv ) 
	--LG("state_tshd" , "function State_Tshd_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local defsa_dif = 0.03 * statelv 
	local defsa = math.floor ( ( DefSa(role) + defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	ALLExAttrSet(role)  
end 

function State_Tshd_Rem ( role , statelv ) 
	--LG("state_xlzh" , "function State_Tshd_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local defsa_dif = 0.03 * statelv 
	local defsa = math.floor ( ( DefSa(role) - defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	ALLExAttrSet(role)  
end 

--�����������ϡ���������������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Xlpz ( sklv )										
	local sp_reduce = 0  
	return sp_reduce 
end

function SkillCooldown_Xlpz( sklv )
	local Cooldown = 1000
	return Cooldown
end

function Skill_Xlpz_Begin ( role , sklv ) 
	local sp = Sp( role ) 
	local sp_reduce = SkillSp_Xlpz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Xlpz_End ( ATKER , DEFER , sklv )  
	local statelv = sklv 
	local statetime = -1  
	----bossʹ�ü��ܴ���
	if GetChaTypeID( ATKER ) == 984 then
		statelv = 10
	end
	----bossʹ�ü��ܴ�������
        AddState( ATKER , DEFER , STATE_MFD, statelv , statetime )
	--LG("skill_Xlpz", "function Skill_Oper_Xlpz: " , "add state xlpz " , "\n" ) 
---------------������״̬
	CheckAttackState1( ATKER , DEFER )		
		
end 

--����Ǳ�С���������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_Ys ( sklv ) 
	local sp_reduce = 10  
	return sp_reduce 
end 

function SkillCooldown_Ys( sklv ) 
	local Cooldown = 30000 
	return Cooldown 
end 

function Skill_Ys_Begin ( role , sklv ) 
	--LG( "skill_ys", "enter function Skill_Atk_Ys : " , "\n" ) 
	--LG("skill_ys", "function Skill_Atk_Ys : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Ys ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Ys_End ( ATKER , DEFER , sklv ) 
	--LG( "skill_ys", "enter function Skill_Def_Ys : " , "\n" ) 
	local statelv = sklv 
	local statetime = 20 + sklv * 10
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local agi_atker = Agi(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
	if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
		if Can_Pk_Garner2 == 0 then
			statetime = 20 + agi_atker/4 + sklv*5
	--		Notice ( "statetime="..statetime)
		end
	end
	AddState ( ATKER , DEFER , STATE_YS , statelv , statetime ) 
	
	--LG("skill_ys", "function Skill_Def_Ys : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
-----������״̬
	CheckAttackState1( ATKER , DEFER )
end 



function State_Ys_Add ( role , statelv ) 
	--LG("state_Ys" , "function State_Ys_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local sp = Sp(role) 
	local sp_reduce = 10 - math.floor ( statelv * 0.5  ) 
--	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( role )
	local agi_atker = Agi(role)
	local Can_Pk_Garner2 = Is_NormalMonster (role)
--	if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" then
--		if Can_Pk_Garner2 == 0 then
--			local mspdsa_dif = 0.02 + 0.005 * statelv 
--			local aspdsa_dif = 0.02 + 0.005 * statelv 
--			local mspdsa = math.floor ( (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX) 
--	--		local aspdsa = math.floor ( (AspdSa(role) + aspdsa_dif ) * ATTR_RADIX)
--			SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
--			SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )
--			ALLExAttrSet(role) 
--			local sp_reduce = 12 - agi_atker/60 
--		end
--	end
	sp = sp - sp_reduce 
	if sp <= 0 then			--sp����ʱ�Ƴ�����״̬ 
		RemoveState ( role , STATE_YS ) 
		return 
	end 
	SetCharaAttr ( sp , role , ATTR_SP ) 
end 

function State_Ys_Rem ( role , statelv ) 
	local map_name_DEFER = GetChaMapName ( role )
	local agi_atker = Agi(role)
	local Can_Pk_Garner2 = Is_NormalMonster (role)
--	if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" then
--		if Can_Pk_Garner2 == 0 then
--			local mspdsa_dif = 0.02 + 0.005 * statelv 
--			Notic("State_Ys_Rem")
--			local aspdsa_dif = 0.02 + 0.005 * statelv 
--			local mspdsa = math.floor ( (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX) 
--	--		local aspdsa = math.floor ( (AspdSa(role) - aspdsa_dif ) * ATTR_RADIX)
--			SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
--			SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )
--			ALLExAttrSet(role) 
--		end
--	end
end 



--���ܺ�����ơ�������������������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Hzcr ( sklv )										
	local sp_reduce = 20 + sklv * 1  
	return sp_reduce 
end

function SkillCooldown_Hzcr( sklv )
	local Cooldown = 12000
	return Cooldown
end

function Skill_Hzcr_Begin ( role , sklv ) 
	--LG( "skill_hzcr", "enter function Skill_Atk_Hzcr : " , "\n" ) 
	--LG("skill_hzcr", "function Skill_Atk_Hzcr : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Hzcr ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Hzcr_End ( ATKER , DEFER , sklv ) 
--	LG( "skill_hzcr", "enter function Skill_Def_Hzcr : " , "\n" ) 
--	a = ChaIsBoat ( ATKER ) 
--	if a == 1 then 
--		LG ( "skill_hzcr" , " ATKER��ɫ��̬����Ϊ��ֻ = " , a ) 
--	else 
--		LG ( "skill_hzcr" , " ATKER��ɫ��̬����Ϊ���� = " , a ) 
--	end 
--	b = ChaIsBoat ( DEFER ) 
--	if b == 1 then 
--		LG ( "skill_hzcr" , " DEFER��ɫ��̬����Ϊ��ֻ = " , b ) 
--	else 
--		LG ( "skill_hzcr" , " DEFER��ɫ��̬����Ϊ���� = " , b ) 
--	end 
	local statelv = sklv 
	local statetime =math.floor ( 6 + sklv * 0.5 ) 
	local role1 = TurnToCha ( ATKER )
	local Check_Heilong  = CheckItem_Heilong ( role1)
		if Check_Heilong == 1 then
			local Percentage = Percentage_Random ( 0.8 )
			if Percentage == 1 then
				  statetime =  statetime*2
				CALCULATE_SKILLEFFECT_LUA_000074 = GetResString("CALCULATE_SKILLEFFECT_LUA_000074")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000074)
			end
	end
	
	local hp_defer = Mxhp ( DEFER ) 
	if hp_defer >= 1000000 then 
		local a = Percentage_Random (0.5)
		if a == 1 then
			statetime = math.floor ( 6 + sklv * 0.5 ) 
		else
			SetSus( DEFER , 0 )
			CALCULATE_SKILLEFFECT_LUA_000075 = GetResString("CALCULATE_SKILLEFFECT_LUA_000075")
			SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000075 ) 
			return
		end
	end 

	AddState ( ATKER , DEFER , STATE_HZCR , statelv , statetime ) 
--	LG("skill_hzcr", "function Skill_Def_Hzcr : " , "ATKER = " , ATKER , "DEFER = ", DEFER , "sklv =  " , sklv , "\n" ) 
----------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
		
end 


function State_Hzcr_Add ( role , statelv ) 
	local dmg = 10 + statelv * 2 
	Endure_Dmg ( role , dmg ) 
end 

function State_Hzcr_Rem ( role , statelv ) 
end
-------------���ܳ���---------------------------------------------------------------------------------------------------------------
function SkillSp_CHF ( sklv )										
	local sp_reduce = 10  
	return sp_reduce 
end 

function SkillCooldown_CHF( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_CHF_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_CHF ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_CHF_End ( ATKER , DEFER , sklv )

	local statelv = sklv 
	local statetime = 10 + sklv  
        local mxhp = Mxhp ( DEFER )
	local hate = mxhp
	
	if ValidCha ( ATKER ) == 0 then
		CALCULATE_SKILLEFFECT_LUA_000076 = GetResString("CALCULATE_SKILLEFFECT_LUA_000076")
		LG("Skill_CHF" , CALCULATE_SKILLEFFECT_LUA_000076)
		SkillUnable( ATKER )   
		return
	end
	
	if ValidCha ( DEFER ) == 0 then
		CALCULATE_SKILLEFFECT_LUA_000077 = GetResString("CALCULATE_SKILLEFFECT_LUA_000077")
		LG("Skill_CHF" , CALCULATE_SKILLEFFECT_LUA_000077)
		SkillUnable( ATKER )   
		return
	end
	
	if IsPlayer( DEFER ) == 1 then
		CALCULATE_SKILLEFFECT_LUA_000078 = GetResString("CALCULATE_SKILLEFFECT_LUA_000078")
		LG("Skill_CHF" , CALCULATE_SKILLEFFECT_LUA_000078)
		SkillUnable( ATKER )   
		return
	end
	AddState( ATKER , DEFER , STATE_CHF, statelv , statetime )
	AddHate ( DEFER , ATKER , hate )


	Check_Ys_Rem ( ATKER , DEFER)
-----------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
		
end 

function State_Chf_Add ( role , statelv )
		local map_name_DEFER = GetChaMapName ( role )
		local Can_Pk_Garner2 = Is_NormalMonster (role)
		
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
		local sklv =math.floor(statelv)-1
		local CfLv = (statelv - sklv)*10
		--	if Can_Pk_Garner2 == 0 then
				if CfLv ~= 0 then
				--	local statelv = sklv  
					local defsa_dif = 0.02 * CfLv 
					local defsa = math.floor ( (DefSa(role) - defsa_dif ) * ATTR_RADIX )
					SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
					ALLExAttrSet(role)
				end	
	--		end
		end

end

function State_Chf_Rem ( role , statelv )
	local HateList = {}
	local Hate = {}
	local i = 0
	local HateMax = 0
	local ATKER = role
	local mxhp = Mxhp ( role )
	local hate = mxhp * -1
		local map_name_DEFER = GetChaMapName ( role )
		local Can_Pk_Garner2 = Is_NormalMonster (role)
		
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
		local sklv =math.floor(statelv)-1
		local CfLv = (statelv - sklv)*10
		Notice("CfLv ="..CfLv)
		--	if Can_Pk_Garner2 == 0 then
				if CfLv ~= 0 then
				--	local statelv = sklv  
					local defsa_dif = 0.02 * CfLv 
					local defsa = math.floor ( (DefSa(role) + defsa_dif ) * ATTR_RADIX )
					SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
					ALLExAttrSet(role)
				end	
	--		end
		end
	for i = 1 , 5 , 1 do
		HateList[i] , Hate[i] = GetChaHateByNo ( role , i-1 )
			
	end
	for i = 1 , 5 , 1 do
		if Hate[i] > HateMax then
			HateMax = Hate[i]
		end
	end
	for i = 1 , 5 , 1 do
		if Hate[i] == HateMax then
			ATKER = HateList[i]
		end
	end
	
	if ValidCha ( role ) == 0 then
		CALCULATE_SKILLEFFECT_LUA_000079 = GetResString("CALCULATE_SKILLEFFECT_LUA_000079")
		LG("Skill_CHF" , CALCULATE_SKILLEFFECT_LUA_000079)
		SkillUnable( role )   
		return
	end

	if ValidCha ( ATKER ) == 0 then
		CALCULATE_SKILLEFFECT_LUA_000080 = GetResString("CALCULATE_SKILLEFFECT_LUA_000080")
		LG("Skill_CHF" , CALCULATE_SKILLEFFECT_LUA_000080)
--		SkillUnable( role )   
		return
	end
	
	
	AddHate ( role  , ATKER , hate )

end 

-----------��������---------------------------------------------------------------------------------------------------------------

function SkillArea_Circle_Pax ( sklv )										
	local side = 200 + 20 * sklv 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Pax( sklv )
	local Cooldown = 4000 - sklv * 200
	return Cooldown
end

function SkillPre_Pax ( sklv )									
end 

function SkillSp_Pax ( sklv )										
	local sp_reduce = 20
	return sp_reduce 
end 


function Skill_Pax_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Pax ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Pax_End ( ATKER , DEFER , sklv ) 
	
	local HateList = {}
	local Hate = {}
	local i = 0
	local HateMax = 0
	local Hate_dif = 0
	local Hate_fin = 0
	local statelv = sklv
	local statetime = 3
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
	local CfLv = GetSkillLv (ATKER,242)
	local PxLv = GetSkillLv (ATKER,243)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			statelv = sklv + CfLv/10
		end
	if ValidCha ( ATKER ) == 0 then
			CALCULATE_SKILLEFFECT_LUA_000076 = GetResString("CALCULATE_SKILLEFFECT_LUA_000076")
			LG("Skill_PAX" , CALCULATE_SKILLEFFECT_LUA_000076)
			SkillUnable( ATKER )   
			return
	end
	
	if ValidCha ( DEFER ) == 0 then
			CALCULATE_SKILLEFFECT_LUA_000077 = GetResString("CALCULATE_SKILLEFFECT_LUA_000077")
			LG("Skill_PAX" , CALCULATE_SKILLEFFECT_LUA_000077)
			SkillUnable( ATKER )   
			return
	end
	
	if  IsPlayer( DEFER ) == 0 then
		for i = 1 , 5 , 1 do
			HateList[i] , Hate[i] = GetChaHateByNo ( DEFER , i-1 )
				
		end
		for i = 1 , 5 , 1 do
			if Hate[i] > HateMax then
				HateMax = Hate[i]
			end
		end
		for i = 1 , 5 , 1 do
			if HateList[i] == ATKER then
				Hate_dif = Hate[i]
			end
		end
		
		local mxhp = Mxhp ( DEFER )
		local hate = mxhp

		
		
		AddState( ATKER , DEFER , STATE_CHF, statelv , statetime )
		
		AddHate( DEFER , ATKER , hate )

		Check_Ys_Rem ( ATKER , DEFER)
-----------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
		
	end
end 























--���ܶ�����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������


function Skill_Dpsl_Use( role , sklv ) 
	--LG("skill_dpsl", "enter function Skill_Oper_Dpsl:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local defsb_dif = 3 * statelv 
	local resistsb_dif = 1 * statelv 
	local mspdsa_dif = (-1) * 0.02 * statelv 
	local defsb = DefSb(role) + defsb_dif  
	local resistsb = ResistSb(role) + resistsb_dif 
	local mspdsa = MspdSa(role) + mspdsa_dif 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 
	SetCharaAttr( resistsb , role , ATTR_STATEV_PDEF ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)  
end 



function Skill_Dpsl_Unuse( role , sklv ) 
	local statelv = sklv 
	local defsb_dif = 3 * statelv 
	local resistsb_dif = 1 * statelv 
	local mspdsa_dif = (-1) *  0.02 * statelv 
	local defsb = DefSb(role) - defsb_dif  
	local resistsb = ResistSb(role) - resistsb_dif 
	local mspdsa = MspdSa(role) - mspdsa_dif 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 
	SetCharaAttr( resistsb , role , ATTR_STATEV_PDEF ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 

--function State_Dpsl_Add ( role , statelv ) 
--	LG("state", "function State_Dpsl_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 



--function State_Dpsl_Rem ( role , statelv ) 
--	LG("state", "function State_Dpsl_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 



--���ܾ޽���������������������������������������������������������������������������������������������������������������������������������������������


function Skill_Jjsl_Use( role , sklv ) 
	--LG("skill_jjslsl", "enter function Skill_Oper_Jjsl:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local atksb_dif = 7 * statelv 
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	local map_name_ATKER = GetChaMapName ( role )
--	local map_name_DEFER = GetChaMapName ( DEFER )
--	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
	local JianLv = GetSkillLv (role,62)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			local hitsa_dif = (1) * (  0.02 * JianLv ) 
			local hitsa = math.floor (  (HitSa(role) + hitsa_dif ) * ATTR_RADIX ) 
			SetCharaAttr( hitsa , role , ATTR_STATEC_HIT ) 
		end
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
	--LG("skill_jjsl", "function Skill_Oper_Jjsl: " , "add state jjsl " , "\n" ) 
end 



function Skill_Jjsl_Unuse( role , sklv ) 
	local statelv = sklv 
	local atksb_dif = 7 * statelv 
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
		local map_name_ATKER = GetChaMapName ( role )
--	local map_name_DEFER = GetChaMapName ( DEFER )
--	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
	local JianLv = GetSkillLv (role,62)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			local hitsa_dif = (1) * (  0.02 * JianLv ) 
			local hitsa = math.floor (  (HitSa(role) - hitsa_dif ) * ATTR_RADIX ) 
			SetCharaAttr( hitsa , role , ATTR_STATEC_HIT ) 
		end
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 

--function State_Jjsl_Add ( role , statelv ) 
--	LG("state", "function State_Jjsl_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 



--function State_Jjsl_Rem ( role , statelv ) 
--	LG("state", "function State_Jjsl_Rem : " ,"statelv = " , statelv , " role = ", role, "\n" ) 

--end 


--���ܽ�����������������������������������������������������������������������������������������������������������������������������������������������


function Skill_Jssl_Use( role , sklv ) 
	--LG("skill_jssl", "enter function Skill_Oper_Jssl:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local atksb_dif = 4 * statelv 
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
	--LG("skill_jssl", "function Skill_Oper_Jssl: " , "add state Jssl " , "\n" ) 
end 



function Skill_Jssl_Unuse( role , sklv ) 
	local statelv = sklv 
	local atksb_dif = 4 * statelv 
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 

--function State_Jssl_Add ( role , statelv ) 
--	LG("state", "function State_Jssl_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 



--function State_Jssl_Rem ( role , statelv ) 
--	LG("state", "function State_Jssl_Rem : " ,"statelv = " , statelv , " role = ", role, "\n" ) 

--end 




--�����޻����ʡ�������������������������������������������������������������������������������������������������������������������������������������������������������
function Skill_Shtz_Use( role , sklv ) 
	--LG("skill_shtz", "enter function Skill_Oper_Shtz:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local mxhpsb_dif = 50 * statelv 
	local mxhpsb = MxhpSb(role) + mxhpsb_dif  
	SetCharaAttr( mxhpsb , role , ATTR_STATEV_MXHP ) 
	ALLExAttrSet(role)  
	--LG("skill_shtz", "function Skill_Oper_Shtz: " , "add state shtz " , "\n" ) 
end 

function Skill_Shtz_Unuse( role , sklv ) 
	local statelv = sklv 
	local mxhpsb_dif = 50 * statelv 
	local mxhpsb = MxhpSb(role) - mxhpsb_dif  
	SetCharaAttr( mxhpsb , role , ATTR_STATEV_MXHP ) 
	ALLExAttrSet(role)  
	--LG( " Luaerror " , " ���ܡ����޻����ʵ��÷�ʽ����" ,  "���÷�ʽtranxwer_type = " , tranxwer_type , "\n" ) 
end 

--function State_Shtz_Add ( role , statelv ) 
--	LG("state", "function State_Shtz_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Shtz_Rem ( role , statelv ) 
--	LG("state", "function State_Shtz_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--����ǿ�����ʡ�������������������������������������������������������������������������������������������������������������������������������������������������������
function Skill_Qhtz_Use( role , sklv ) 
	--LG("skill_qhtz", "enter function Skill_Oper_Qhtz:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local mxhpsb_dif = 20 * statelv + Con(role) * 3 
	local mxhpsb = MxhpSb(role) + mxhpsb_dif  
	local map_name_ATKER = GetChaMapName ( role )
	--local map_name_DEFER = GetChaMapName ( DEFER )
	--local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			local GTYZ_Lv = GetSkillLv(role,63)
			local  resistsb_dif = 1 * GTYZ_Lv
			local resistsb = ResistSb(role) + resistsb_dif
			SetCharaAttr( resistsb , role , ATTR_STATEV_PDEF )
		end
	
	SetCharaAttr( mxhpsb , role , ATTR_STATEV_MXHP ) 
	ALLExAttrSet(role)  
	--LG("skill_qhtz", "function Skill_Oper_Qhtz: " , "add state qhtz " , "\n" ) 
end 

function Skill_Qhtz_Unuse( role , sklv ) 
	local statelv = sklv 
	local mxhpsb_dif = 20 * statelv + Con(role) * 3 
	local mxhpsb = MxhpSb(role) - mxhpsb_dif  
	local map_name_ATKER = GetChaMapName ( role )
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			local GTYZ_Lv = GetSkillLv(role,63)
			local  resistsb_dif = 1 * GTYZ_Lv
			local resistsb = ResistSb(role) - resistsb_dif
			SetCharaAttr( resistsb , role , ATTR_STATEV_PDEF )
		end
	SetCharaAttr( mxhpsb , role , ATTR_STATEV_MXHP ) 
	ALLExAttrSet(role)  
	--LG( " Luaerror " , " ���ܡ���ǿ�����ʵ��÷�ʽ����" ,  "���÷�ʽtranxwer_type = " , tranxwer_type , "\n" ) 
end 

--function State_Qhtz_Add ( role , statelv ) 
--	LG("state", "function State_Qhtz_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Qhtz_Rem ( role , statelv ) 
--	LG("state", "function State_Qhtz_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 


--�������ɻرܡ�������������������������������������������������������������������������������������������������������������������������������������������������������
function Skill_Lqhb_Use( role , sklv ) 
	--LG("skill_lqhb", "enter function Skill_Oper_Lqhb:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local fleesb_dif = 3 * statelv 
	local fleesb = FleeSb(role) + fleesb_dif  
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE ) 
	ALLExAttrSet(role)  
	--LG("skill_lqhb", "function Skill_Oper_Lqhb: " , "add state lqhb " , "\n" ) 
end 

function Skill_Lqhb_Unuse( role , sklv ) 
	local statelv = sklv 
	local fleesb_dif = 3 * statelv 
	local fleesb = FleeSb(role) - fleesb_dif  
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE ) 
	ALLExAttrSet(role)  
	--LG( " Luaerror " , " ���ܡ����޻����ʵ��÷�ʽ����" ,  "���÷�ʽtranxwer_type = " , tranxwer_type , "\n" ) 
end 

--function State_Lqhb_Add ( role , statelv ) 
--	LG("state", "function State_Lqhb_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Lqhb_Rem ( role , statelv ) 
--	LG("state", "function State_Lqhb_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 


--���ܽ���רע��������������������������������������������������������������������������������������������������������������������������������������������������������
function Skill_Jdzz_Use( role , sklv ) 
	--LG("skill_jdzz", "enter function Skill_Oper_Jdzz:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local hitsb_dif = 1 * statelv 
	local hitsb = HitSb(role) + hitsb_dif  
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 
	ALLExAttrSet(role)  
	--LG("skill_jdzz", "function Skill_Oper_Jdzz: " , "add state jdzz " , "\n" ) 
end 

function Skill_Jdzz_Unuse( role , sklv ) 
	local statelv = sklv 
	local hitsb_dif = 1 * statelv 
	local hitsb = HitSb(role) - hitsb_dif  
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 
	ALLExAttrSet(role)  
	--LG( " Luaerror " , " ���ܡ����޻����ʵ��÷�ʽ����" ,  "���÷�ʽtranxwer_type = " , tranxwer_type , "\n" ) 
end 

--function State_Jdzz_Add ( role , statelv ) 
--	LG("state", "function State_Jdzz_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Jdzz_Rem ( role , statelv ) 
--	LG("state", "function State_Jdzz_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 


--������ţ��Ѫ��������������������������������������������������������������������������������������������������������������������������������������������������������
function Skill_Mnrx_Use( role , sklv ) 
	--LG("skill_mnrx", "enter function Skill_Oper_Mnrx:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local mxhpsa_dif = 0.1 + 0.02 * statelv 
	local defsa_dif = 0.1 + 0.02 * statelv 
	local mxhpsa = math.floor ( (MxhpSa(role) + mxhpsa_dif ) * ATTR_RADIX )
	local defsa = math.floor ( (DefSa(role) + defsa_dif ) * ATTR_RADIX )	
	local map_name_ATKER = GetChaMapName ( role )
--	local map_name_DEFER = GetChaMapName ( DEFER )
--	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
	local GangTieLv = GetSkillLv (role,63)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			local hrecsb_dif =  10 * GangTieLv  
			local hrecsb = math.floor ( ( HrecSb ( role ) + hrecsb_dif )  ) 
			SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 
		end
	SetCharaAttr( mxhpsa , role , ATTR_STATEC_MXHP ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 

	ALLExAttrSet(role)  
	--LG("skill_mnrx", "function Skill_Oper_Mnrx: " , "add state mnrx " , "\n" ) 
end 
 
function Skill_Mnrx_Unuse( role , sklv ) 
	local statelv = sklv 
	local mxhpsa_dif = 0.1 + 0.02 * statelv 
	local defsa_dif = 0.1 + 0.02 * statelv 
	local mxhpsa = math.floor ( (MxhpSa(role) - mxhpsa_dif ) * ATTR_RADIX )
	local defsa = math.floor ( (DefSa(role) - defsa_dif ) * ATTR_RADIX )
		local map_name_ATKER = GetChaMapName ( role )
--	local map_name_DEFER = GetChaMapName ( DEFER )
--	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
	local GangTieLv = GetSkillLv (role,63)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			local hrecsb_dif =  10 * GangTieLv  
			local hrecsb = math.floor ( ( HrecSb ( role ) + hrecsb_dif )  ) 
			SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 
		end
	SetCharaAttr( mxhpsa , role , ATTR_STATEC_MXHP ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	ALLExAttrSet(role)  
end 

--function State_Mnrx_Add ( role , statelv ) 
--	LG("state", "function State_Mnrx_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Mnrx_Rem ( role , statelv ) 
--	LG("state", "function State_Mnrx_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 
--���ܻ�Ӱ����������������������������������������������������������������������������������������������������������������������������������������������������������
function Skill_Hys_Use( role , sklv ) 
	--LG("skill_hys", "enter function Skill_Oper_Hys:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local fleesb_dif =4 * statelv 
	local fleesb = math.floor ( ( FleeSb(role) + fleesb_dif  )    )  
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE ) 
	ALLExAttrSet(role)  
	--LG("skill_hys", "function Skill_Oper_Hys: " , "add state hys " , "\n" ) 
end 

function Skill_Hys_Unuse( role , sklv ) 
	local statelv = sklv 
	local fleesb_dif = 4 * statelv 
	local fleesb = math.floor ( ( FleeSb(role) - fleesb_dif  )  )  
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE ) 
	ALLExAttrSet(role)  
end 

--function State_Hys_Add ( role , statelv ) 
--	LG("state", "function State_Hys_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Hys_Rem ( role , statelv ) 
--	LG("state", "function State_Hys_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 


--������Ѫ�񹥡�������������������������������������������������������������������������������������������������������������������������������������������������������
function Skill_Pxkg_Use( role , sklv ) 
	--LG("skill_pxkg", "enter function Skill_Oper_Pxkg:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv 
	local aspdsa_dif =  ( 0.1 + 0.01 * statelv ) 
	local map_name_ATKER = GetChaMapName ( role )
--	local map_name_DEFER = GetChaMapName ( DEFER )
	local str_atker = Str(role)
	--local Can_Pk_Garner2 = Is_NormalMonster (role)
	--	if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" then
	--		if Can_Pk_Garner2 == 0 then
	--			aspdsa_dif = ( 0.1 + str_atker/20000 * statelv ) 
		--		Notice ( "statetime="..statetime)
	--		end
	--	end
	local aspdsa = math.floor ( ( AspdSa(role) + aspdsa_dif  ) * ATTR_RADIX   )  
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet(role)  
	--LG("skill_pxkg", "function Skill_Oper_Pxkg: " , "add state pxkg " , "\n" ) 
end 

function Skill_Pxkg_Unuse( role , sklv ) 
	local statelv = sklv 
	local aspdsa_dif =  ( 0.1 + 0.01 * statelv ) 
	local aspdsa = math.floor ( ( AspdSa(role) - aspdsa_dif  ) * ATTR_RADIX   )  
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet(role)  
end 

--function State_Pxkg_Add ( role , statelv ) 
--	LG("state", "function State_Pxkg_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Pxkg_Rem ( role , statelv ) 
--	LG("state", "function State_Pxkg_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--�������ʻظ���������������������������������������������������������������������������������������������������������������������������������������������������������
function Skill_Tzhf_Use( role , sklv ) 
	--LG("skill_tzhf", "enter function Skill_Oper_tzhf:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local hrecsb_dif =  statelv  
	local hrecsb = math.floor ( ( HrecSb(role) + hrecsb_dif  ) * ATTR_RADIX   )  
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 
	ALLExAttrSet(role)  
	--LG("skill_tzhf", "function Skill_Oper_tzhf: " , "add state tzhf " , "\n" ) 
end 

function Skill_Tzhf_Unuse( role , sklv ) 
	local statelv = sklv 
	local hrecsb_dif =  statelv  
	local hrecsb = math.floor ( ( HrecSb(role) - hrecsb_dif  ) * ATTR_RADIX   )  
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 
	ALLExAttrSet(role)  
end 

--function State_Tzhf_Add ( role , statelv ) 
--	LG("state", "function State_tzhf_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Tzhf_Rem ( role , statelv ) 
--	LG("state", "function State_tzhf_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--���ܾ���֮�ܡ�������������������������������������������������������������������������������������������������������������������������������������������������������

function Skill_Zjft_Use( role , sklv ) 
	--LG("skill_zjft", "enter function Skill_Oper_Zjft:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	AddState ( role , role , STATE_ZJFT , statelv , -1 ) 
	--LG("skill_zjft", "function Skill_Oper_Zjft: " , "add state zjft " , "\n" ) 
end 


function Skill_Zjft_Unuse( role , sklv ) 
	local statelv = sklv 
	RemoveState ( role , STATE_ZJFT ) 
	--LG( " Luaerror" , " ���ܡ����ؼ׷������÷�ʽ����" ,  "���÷�ʽtranxwer_type = " , tranxwer_type , "\n" ) 
end 

--���ܹ���������ʽ��������������������������������������������������������������������������������������������������������

function Skill_Gjsl_Use( role , sklv ) 
	--LG("skill_gjsl", "enter function Skill_Oper_Gjsl:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local mnatksb_dif = 2 * statelv 
	local mxatksb_dif = 2 * statelv 
	local mnatksb = MnatkSb(role) + mnatksb_dif 
	local mxatksb = MxatkSb(role) + mxatksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
	--LG("skill_gjsl", "function Skill_Oper_Gjsl: " , "add state gjsl " , "\n" ) 
end 



function Skill_Gjsl_Unuse( role , sklv ) 
	local statelv = sklv 
	local mnatksb_dif = 2 * statelv 
	local mxatksb_dif = 2 * statelv 
	local mnatksb = MnatkSb(role) - mnatksb_dif 
	local mxatksb = MxatkSb(role) - mxatksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
	--LG( " Luaerror" , " ���ܡ��������������÷�ʽ����" ,  "���÷�ʽtranxwer_type = " , tranxwer_type , "\n" ) 
end 

--function State_Gjsl_Add ( role , statelv ) 
--	LG("state", "function State_Gjsl_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Gjsl_Rem ( role , statelv ) 
--	LG("state", "function State_Gjsl_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--���ܼ��粽��������������������������������������������������������������������������������������������������������������������������������������������������������
function Skill_Jfb_Use( role , sklv ) 
	--LG("skill_jfb", "enter function Skill_Oper_jfb:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local mspdsa_dif =  statelv * 0.02   
	local mspdsa = (MspdSa(role) + mspdsa_dif) * ATTR_RADIX  
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
	--LG("skill_jfb", "function Skill_Oper_jfb: " , "add state jfb " , "\n" ) 
	
end 

function Skill_Jfb_Unuse( role , sklv ) 
	local statelv = sklv 
	local mspdsa_dif =  statelv * 0.02 
	local mspdsa = (MspdSa(role) - mspdsa_dif) *  ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 

--function State_Jfb_Add ( role , statelv ) 
--	LG("state", "function State_jfb_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Jfb_Rem ( role , statelv ) 
--	LG("state", "function State_jfb_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--���ܾ���ӳ֡�������������������������������������������������������������������������������������������������������������������������������������������

function Skill_Jsjc_Use( role , sklv ) 
	--LG("skill_jsjc", "enter function Skill_Oper_jsjc:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local mxspsb_dif =  statelv * 40    
	local mxspsb = math.floor ( MxspSb(role) + mxspsb_dif  )  
	SetCharaAttr( mxspsb , role , ATTR_STATEV_MXSP ) 
	ALLExAttrSet(role)  
	--LG("skill_jsjc", "function Skill_Oper_jsjc: " , "add state jsjc " , "\n" ) 
end 

function Skill_Jsjc_Unuse( role , sklv ) 
	local statelv = sklv 
	local mxspsb_dif =  statelv * 40    
	local mxspsb = math.floor ( MxspSb(role) - mxspsb_dif  )  
	SetCharaAttr( mxspsb , role , ATTR_STATEV_MXSP ) 
	ALLExAttrSet(role)  
end 

--function State_Jsjc_Add ( role , statelv ) 
--	LG("state", "function State_jsjc_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Jsjc_Rem ( role , statelv ) 
--	LG("state", "function State_jsjc_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--�������ӡ�������������������������������������������������������������������������������������������������������������������������������

function Skill_Sy_Use( role , sklv ) 
	--LG("skill_sy", "enter function Skill_Oper_Sy:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local srecsb_dif = 1+statelv*1   
	local srecsb = SrecSb(role) + srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 
	ALLExAttrSet(role)  
	--LG("skill_sy", "function Skill_Oper_Sy: " , "add state sy " , "\n" ) 
end 



function Skill_Sy_Unuse( role , sklv ) 
	local statelv = sklv 
	local srecsb_dif = 2+statelv*1  
	local srecsb = SrecSb(role) - srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 
	ALLExAttrSet(role)  
end 

--function State_Sy_Add ( role , statelv ) 
--	LG("state", "function State_Sy_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--function State_Sy_Rem ( role , statelv ) 
--	LG("state", "function State_Sy_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

--end 



--���ܼ��͡�������������������������������������������������������������������������������������������������������������������������������

function Skill_Jr_Use( role , sklv ) 
	--LG("skill_jr", "enter function Skill_Oper_Jr:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local srecsb_dif = 1+statelv*1   
	local srecsb = SrecSb(role) + srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 
	ALLExAttrSet(role)  
	--LG("skill_jr", "function Skill_Oper_Jr: " , "add state jr " , "\n" ) 
end 



function Skill_Jr_Unuse( role , sklv ) 
	local statelv = sklv 
	local srecsb_dif = 1+statelv*1  
	local srecsb = SrecSb(role) - srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 
	ALLExAttrSet(role)  
end 




--����˳����������������������������������������������������������������������������������������������������������������������������������

function Skill_Sl_Use( role , sklv ) 
--	LG("skill_sl", "enter function Skill_Oper_Sl:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_mspdsa_dif = 0.05 + statelv * 0.01    
	local ship_mspdsa = ( Ship_MspdSa ( role ) + ship_mspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( ship_mspdsa , role , ATTR_BOAT_SKILLC_MSPD ) 
	ALLExAttrSet(role)  
end 



function Skill_Sl_Unuse( role , sklv ) 
--	LG("skill_sl", "enter function Skill_Sl_Unuse:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_mspdsa_dif = 0.05 + statelv * 0.01    
	local ship_mspdsa = ( Ship_MspdSa ( role ) - ship_mspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( ship_mspdsa , role , ATTR_BOAT_SKILLC_MSPD ) 
	ALLExAttrSet(role)  
end 

--���ܱ���װ��------------------------------------------------------------����������������������������������������������������������������������������������������������������������������
function Skill_Bkzj_Use( role , sklv ) 
--	LG("skill_Bkzj", "enter function Skill_Oper_Bkzj:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_defsb_dif = statelv * 8    
	local ship_defsb = ( Ship_DefSb ( role ) + ship_defsb_dif )
	SetCharaAttr( ship_defsb , role , ATTR_BOAT_SKILLV_DEF ) 
	ALLExAttrSet(role)  
end 



function Skill_Bkzj_Unuse( role , sklv ) 
--	LG("skill_Bkzj", "enter function Skill_Oper_Bkzj:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_defsb_dif = statelv * 8    
	local ship_defsb = ( Ship_DefSb ( role ) - ship_defsb_dif )
	SetCharaAttr( ship_defsb , role , ATTR_BOAT_SKILLV_DEF ) 
	ALLExAttrSet(role)  
end 


--���ܻ�������------------------------------------------------------------����������������������������������������������������������������������������������������������������������������
function Skill_Hpsl_Use( role , sklv ) 
--	LG("skill_Hpsl", "enter function Skill_Oper_Hpsl:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_mxatk_dif = statelv * 25
	local ship_mnatk_dif = statelv * 25
	local ship_mxatk = ( Ship_Mxatk ( role ) + ship_mxatk_dif ) 
	local ship_mnatk = ( Ship_Mnatk ( role ) + ship_mnatk_dif )
	SetCharaAttr( ship_mxatk , role , ATTR_BOAT_SKILLV_MXATK ) 
	SetCharaAttr( ship_mnatk , role , ATTR_BOAT_SKILLV_MNATK ) 
	ALLExAttrSet(role)  
end 



function Skill_Hpsl_Unuse( role , sklv ) 
--	LG("skill_Bkzj", "enter function Skill_Oper_Bkzj:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_mxatk_dif = statelv * 25
	local ship_mnatk_dif = statelv * 25
	local ship_mxatk = ( Ship_Mxatk ( role ) - ship_mxatk_dif ) 
	local ship_mnatk = ( Ship_Mnatk ( role ) - ship_mnatk_dif )
	SetCharaAttr( ship_mxatk , role , ATTR_BOAT_SKILLV_MXATK ) 
	SetCharaAttr( ship_mnatk , role , ATTR_BOAT_SKILLV_MNATK ) 
	ALLExAttrSet(role)  
end 



--���ܼװ�ӹ�------------------------------------------------------------����������������������������������������������������������������������������������������������������������������
function Skill_Jbjg_Use( role , sklv ) 
	LG("skill_Jbjg", "enter function Skill_Oper_Jbjg:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_def_dif = statelv * 12    
	local ship_def = ( Ship_Def ( role ) + ship_def_dif )  
	SetCharaAttr( ship_def , role , ATTR_BOAT_SKILLV_DEF ) 
	ALLExAttrSet(role)  
end 



function Skill_Jbjg_Unuse( role , sklv ) 
	LG("skill_Jbjg", "enter function Skill_Oper_Jbjg:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_def_dif = statelv * 12    
	local ship_def = ( Ship_Def ( role ) - ship_def_dif )  
	SetCharaAttr( ship_def , role , ATTR_BOAT_SKILLV_DEF ) 
	ALLExAttrSet(role)  
end 


--���ܲٷ���------------------------------------------------------------����������������������������������������������������������������������������������������������������������������
function Skill_Cfs_Use( role , sklv ) 
	LG("skill_Cfs", "enter function Skill_Oper_Cfs:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_aspdsa_dif = 0.1 + statelv * 0.02    
	local ship_aspdsa = ( Ship_AspdSa ( role ) + ship_aspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( ship_aspdsa , role , ATTR_BOAT_SKILLC_ASPD ) 
	ALLExAttrSet(role)  
end 



function Skill_Cfs_Unuse( role , sklv ) 
	LG("skill_Cfs", "enter function Skill_Oper_Cfs:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_aspdsa_dif = 0.1 + statelv * 0.02    
	local ship_aspdsa = ( Ship_AspdSa ( role ) - ship_aspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( ship_aspdsa , role , ATTR_BOAT_SKILLC_ASPD ) 
	ALLExAttrSet(role)  
end 


--���ܴ���ǿ��------------------------------------------------------------����������������������������������������������������������������������������������������������������������������
function Skill_Ctqh_Use( role , sklv ) 
	LG("skill_Ctqh", "enter function Skill_Oper_Ctqh:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_hp_dif = statelv * 400    
	local ship_hp = ( Ship_Mxhp ( role ) + ship_hp_dif ) 
	SetCharaAttr( ship_hp , role , ATTR_BOAT_SKILLV_MXUSE ) 
	ALLExAttrSet(role)  
end 



function Skill_Ctqh_Unuse( role , sklv ) 
	LG("skill_Ctqh", "enter function Skill_Oper_Ctqh:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_hp_dif = statelv * 400    
	local ship_hp = ( Ship_Mxhp ( role ) - ship_hp_dif ) 
	SetCharaAttr( ship_hp , role , ATTR_BOAT_SKILLV_MXUSE ) 
	ALLExAttrSet(role)  
end 


--���ܲ�������------------------------------------------------------------����������������������������������������������������������������������������������������������������������������
function Skill_Bjcr_Use( role , sklv ) 
	LG("skill_Bjcr", "enter function Skill_Oper_Bjcr:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_sp_dif = statelv * 30    
	local ship_sp = ( Ship_Mxsp ( role ) + ship_sp_dif ) 
	SetCharaAttr( ship_sp , role , ATTR_BOAT_SKILLV_MXSPLY ) 
	ALLExAttrSet(role)  
end 



function Skill_Bjcr_Unuse( role , sklv ) 
	LG("skill_Bjcr", "enter function Skill_Oper_Bjcr:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local ship_sp_dif = statelv * 30    
	local ship_sp = ( Ship_Mxsp ( role ) - ship_sp_dif ) 
	SetCharaAttr( ship_sp , role , ATTR_BOAT_SKILLV_MXSPLY ) 
	ALLExAttrSet(role)  
end 


--���ܴ������ߡ�����������������������������������������������������������������������������������������������������������������������������������������������������������

function Skill_Clxz_Use( role , sklv )										--���ܴ������ߵļ���
	--LG("skill_clxz", "enter function Skill_Oper_Clxz:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local fleesb_dif = 3 * statelv 
	local fleesb =  FleeSb(role) + fleesb_dif  
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE ) 
	ALLExAttrSet(role)  
	--LG("skill_clxz", "function Skill_Oper_Clxz: " , "add state clxz " , "\n" ) 
end 



function Skill_Clxz_Unuse( role , sklv )									--���ܴ������ߵ�����
	local statelv = sklv 
	local fleesb_dif = 3 * statelv 
	local fleesb =  FleeSb(role) - fleesb_dif  
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE ) 
	ALLExAttrSet(role)  
	--LG( " Luaerror" , " ���ܡ����������ߵ��÷�ʽ����" ,  "���÷�ʽtranxwer_type = " , tranxwer_type , "\n" ) 
end 

--function State_Clxz_Add ( role , statelv )								--״̬�������ߵ�Ч������
--	LG("state", "function State_Clxz_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 



--function State_Clxz_Rem ( role , statelv )								--״̬�������ߵ�Ч������
--	LG("state", "function State_Clxz_Rem : " ," role = ", role, "statelv = " , statelv , "\n" ) 

	
--end 



--��������αװ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������


function Skill_Lrwz_Use( role , sklv ) 
	--LG("skill_lrwz", "enter function Skill_Oper_Lrwz:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local fleesb_dif = 2 * statelv 
	local fleesb = FleeSb(role) + fleesb_dif  
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE ) 
	ALLExAttrSet(role)  
	--LG("skill_lrwz", "function Skill_Oper_Lrwz: " , "add state lrwz " , "\n" ) 
end 



function Skill_Lrwz_Unuse( role , sklv ) 
	local statelv = sklv 
	local fleesb_dif = 2 * statelv 
	local fleesb = FleeSb(role) - fleesb_dif  
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE ) 
	ALLExAttrSet(role)  
end 

--function State_Lrwz_Add ( role , statelv ) 
--	LG("state", "function State_Lrwz_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 



--function State_Lrwz_Rem ( role , statelv ) 
--	LG("state", "function State_Lrwz_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 

--���ܻ�ǹ������������������������������������������������������������������������������������������������������������������������������������������������������������

function Skill_Hqsl_Use( role , sklv ) 
	--LG("skill_hqsl", "enter function Skill_Oper_Hqsl:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local mnatksb_dif = 10 * statelv 
	local mxatksb_dif = 15 * statelv 
	local mnatksb = MnatkSb(role) + mnatksb_dif  
	local mxatksb = MxatkSb(role) + mxatksb_dif  
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
	--LG("skill_hqsl", "function Skill_Oper_Hqsl: " , "add state hqsl " , "\n" ) 
end 


function Skill_Hqsl_Unuse( role , sklv ) 
	local statelv = sklv  
	local mnatksb_dif = 10 * statelv 
	local mxatksb_dif = 15 * statelv 
	local mnatksb = MnatkSb(role) - mnatksb_dif  
	local mxatksb = MxatkSb(role) - mxatksb_dif  
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
	--LG( " Luaerror" , " ���ܡ�����ǹ�������÷�ʽ����" ,  "���÷�ʽtranxwer_type = " , tranxwer_type , "\n" ) 
end 

--function State_Hqsl_Add ( role , statelv ) 
--	LG("state", "function State_Hqsl_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 



--function State_Hqsl_Rem ( role , statelv ) 
--	LG("state", "function State_Hqsl_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 

--end 


--����˫�ֽ��ӳɡ�������������������������������������������������������������������������������������������������������������������������������������������������������


function Skill_Fsz_Use( role , sklv ) 
	--LG("skill_fsz", "enter function Skill_Oper_Fsz:", "sklv = ", sklv ,"role = ", role , "\n") 
	local statelv = sklv  
	local lefthand_rad_dif = statelv * 8 
	local lefthand_rad = GetChaAttr ( role , ATTR_LHAND_ITEMV ) + lefthand_rad_dif 
	SetCharaAttr ( lefthand_rad , role , ATTR_LHAND_ITEMV ) 
	--LG("skill_fsz", "function Skill_Oper_Fsz: " , "add state fsz " , "\n" ) 

end 

function Skill_Fsz_Unuse( role , sklv ) 
	local statelv = sklv 
	local lefthand_rad_dif = statelv * 8 
	local lefthand_rad = GetChaAttr ( role , ATTR_LHAND_ITEMV ) - lefthand_rad_dif 
	SetCharaAttr ( lefthand_rad , role , ATTR_LHAND_ITEMV ) 

end 

--function State_Fsz_Add ( role , statelv ) 
--	LG("state", "function State_Fsz_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 


--end 



--function State_Fsz_Rem ( role , statelv ) 
--	LG("state", "function State_Fsz_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 


--end 





--�������¡�����������������������������������������������������������������������������������������������������������������������������������������������������������

function Skill_Zx_Use( role , sklv ) 
	--LG("skill_zx", "enter function Skill_Oper_Zx:", "sklv = ", sklv ,"role = ", role , "\n") 
	local ys_statelv = GetChaStateLv ( role , STATE_YS ) 
	if ys_statelv >= 1 then  
		RemoveState( role , STATE_YS ) 
	end 
	local hrecsb_dif = 15  
	local hrecsa_dif = 5    
	local hrecsa = math.floor ( (HrecSa(role) + hrecsa_dif )  * ATTR_RADIX) 
	local hrecsb = math.floor ( ( HrecSb ( role ) + hrecsb_dif )  ) 
	--LG("skill_zx" , " form_hrecsa = " , HrecSa(role) , "\n" ) 
	--LG("skill_zx", "hrecsa = ", hrecsa, "\n") 
	--LG("skill_hrecsa" , " form_hrecsa = " , HrecSa(role) , "\n" ) 
	--LG("skill_hrecsa", "hrecsa = ", hrecsa, "\n") 
	SetCharaAttr( hrecsa , role , ATTR_STATEC_HREC ) 
	SetCharaAttr ( hrecsb , role , ATTR_STATEV_HREC ) 

	local srecsb_dif = 5 
	local srecsa_dif = 5    
	local srecsa = math.floor ( (SrecSa(role) + srecsa_dif ) * ATTR_RADIX ) 
	local srecsb = math.floor ( (SrecSb(role) + srecsb_dif )  ) 

	--LG("skill_zx" , " form_srecsa = " , SrecSa(role) , "\n" ) 
	--LG("skill_zx", "srecsa = ", srecsa, "\n") 
	--LG("skill_srecsa" , " form_srecsa = " , SrecSa(role) , "\n" ) 
	--LG("skill_srecsa", "srecsa = ", srecsa, "\n") 
	SetCharaAttr( srecsa , role , ATTR_STATEC_SREC ) 
	SetCharaAttr ( srecsb , role , ATTR_STATEV_SREC ) 
	Check_Ys_Rem ( role , role)
	ALLExAttrSet(role)
end 

function Skill_Zx_Unuse( role , sklv ) 
	--LG("skill_zx", "enter function Skill_Oper_Zx:", "sklv = ", sklv ,"role = ", role , "\n") 

	local hrecsb_dif = 15 
	local hrecsa_dif = 5    
	local hrecsa = math.floor ( (HrecSa(role) - hrecsa_dif )  * ATTR_RADIX) 
	local hrecsb = math.floor ( ( HrecSb ( role ) - hrecsb_dif ) ) 
	--LG("skill_zx" , " form_hrecsa = " , HrecSa(role) , "\n" ) 
	--LG("skill_zx", "hrecsa = ", hrecsa, "\n") 
	--LG("skill_hrecsa" , " form_hrecsa = " , HrecSa(role) , "\n" ) 
	--LG("skill_hrecsa", "hrecsa = ", hrecsa, "\n") 
	SetCharaAttr( hrecsa , role , ATTR_STATEC_HREC ) 
	SetCharaAttr ( hrecsb , role , ATTR_STATEV_HREC ) 

	local srecsb_dif = 5  
	local srecsa_dif = 5    
	local srecsa = math.floor ( (SrecSa(role) - srecsa_dif ) * ATTR_RADIX ) 
	local srecsb = math.floor ( (SrecSb(role) - srecsb_dif )  ) 

	--LG("skill_zx" , " form_srecsa = " , SrecSa(role) , "\n" ) 
	--LG("skill_zx", "srecsa = ", srecsa, "\n") 
	--LG("skill_srecsa" , " form_srecsa = " , SrecSa(role) , "\n" ) 
	--LG("skill_srecsa", "srecsa = ", srecsa, "\n") 
	SetCharaAttr( srecsa , role , ATTR_STATEC_SREC ) 
	SetCharaAttr ( srecsb , role , ATTR_STATEV_SREC ) 

	ALLExAttrSet(role)
end 










--�������Ǽ��ꡪ����������������������������������������������������������������������������������������������������������������������������������������������������������


function SkillArea_Square_Lxjy ( sklv )										--���ܡ����Ǽ���"�ļ�������ʽ
	local side = 400 
	SetSkillRange ( 4 , side )  	
end 

function SkillPre_Lxjy ( sklv )										--����"���Ǽ���"�ļ���ǰ��׼��
end 

function SkillCooldown_Lxjy( sklv )
	local Cooldown = 25000
	return Cooldown
end

function SkillSp_Lxjy ( sklv )										--����"���Ǽ���"��sp���Ĺ�ʽ
	local sp_reduce = 26 + sklv * 2     
	return sp_reduce 
end 


function Skill_Lxjy_Begin ( role , sklv ) 
--   	Check_State ( role , nil ) 
	--LG( "skill_lxjy", "enter function Skill_Atk_Lxjy : " , "\n" ) 
	--LG("skill_lxjy", "function Skill_Atk_Lxjy : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Lxjy ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Lxjy_End ( ATKER , DEFER , sklv ) 
	--LG( "skill_lxjy", "enter function Skill_Def_Lxjy : " , "\n" ) 
	--LG("skill_lxjy", "function Skill_Def_Lxjy : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local hp = Hp( DEFER ) 
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000081 = GetResString("CALCULATE_SKILLEFFECT_LUA_000081")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000081 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000082 = GetResString("CALCULATE_SKILLEFFECT_LUA_000082")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000082 ) 
		return 
	end 
	local dmg = ( 0.5 +sklv * 0.1 ) * Atk_Dmg ( ATKER , DEFER )  
	Hp_Endure_Dmg ( DEFER , dmg )  
	--LG( "Lxjy", "���Ǽ��꼼�ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
		
end 

--�����Ǻ�����������������������������������������������������������������������������������������������������������������������������������������������������������������������������


function SkillArea_Circle_Lh ( sklv )										--���ܡ��Ǻ�"�ļ�������ʽ
	--LG( "skarea_lh", " enter function SkillArea_Circle_Lh : " , "sklv = " ,sklv ) 
	local side = 300 + math.floor ( sklv * 20 ) 
	--LG( "skarea_lh" , " side = " , side ) 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Lh( sklv )
	local Cooldown = 5000
	return Cooldown
end

function SkillPre_Lh ( sklv )										--����"�Ǻ�"�ļ���ǰ��׼��
end 

function SkillSp_Lh ( sklv )										--����"�Ǻ�"��sp���Ĺ�ʽ
	local sp_reduce = 20 - math.floor ( sklv * 0.5 ) 
	return sp_reduce 
end 


function Skill_Lh_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Lh ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Lh_End ( ATKER , DEFER , sklv ) 
	--LG( "sk_lh" , "function Skill_Lh_End : "  , " ������: " , GetChaName(ATKER) , "�ܻ���: " , GetChaName(DEFER), "sklv = " , sklv ) 
	local hp = Hp( DEFER ) 
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000083 = GetResString("CALCULATE_SKILLEFFECT_LUA_000083")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000083 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000084 = GetResString("CALCULATE_SKILLEFFECT_LUA_000084")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000084 ) 
		return 
	end 
	dmg = ( 1+sklv*0.05 ) * Atk_Dmg ( ATKER , DEFER ) 
	Hp_Endure_Dmg ( DEFER , dmg ) 
	if IsPlayer(DEFER) == 1 and IsPlayer(ATKER) == 1 then
		CALCULATE_SKILLEFFECT_LUA_000085 = GetResString("CALCULATE_SKILLEFFECT_LUA_000085")
		SkillLog(ATKER,DEFER,dmg,CALCULATE_SKILLEFFECT_LUA_000085,sklv)
	end	
	--LG( "Lh", "�Ǻ����ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
	Check_Ys_Rem ( ATKER , DEFER)						--�ж��Ƿ�����
		
end 


--���ܻ����ܻ���������������������������������������������������������������������������������������������������������������������
function SkillArea_Sector_Hxdj ( sklv )										--���ܡ������ܻ�"�ļ�������ʽ
	local radius = 400 + math.floor ( sklv * 10 ) 
	local angle = 100 + math.floor ( sklv / 5 ) * 20 
	SetSkillRange ( 2 , radius , angle  )  
end 

function SkillCooldown_Hxdj( sklv )
	local Cooldown = 5000
	return Cooldown
end

function SkillPre_Hxdj ( sklv )										--����"�����ܻ�"�ļ���ǰ��׼��
end 

function SkillSp_Hxdj ( sklv )										--����"�����ܻ�"��sp���Ĺ�ʽ
	local sp_reduce = 20 + sklv * 2  
	return sp_reduce 
end 


function Skill_Hxdj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Hxdj ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Hxdj_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 5  
	local back_dis = 500 
	dmg = math.floor(150 + sklv * 20 )  
	Hp_Endure_Dmg ( DEFER , dmg )  
	AddState ( ATKER , DEFER , STATE_XY , statelv , statetime ) 
	BeatBack(ATKER , DEFER , back_dis) 
	--LG( "Hxdj", "�����ܻ����ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
end 

--����Ұ�����ѡ�����������������������������������������������������������������������������������������������������������������������������������������������


function SkillArea_Circle_Ymsl ( sklv )										--���ܡ�Ұ������"�ļ�������ʽ
	--LG( "skarea_ymsl", " enter function SkillArea_Circle_Ymsl : " , "sklv = " ,sklv ) 
	local side = 200 + math.floor ( sklv * 10 ) 
	--LG( "skarea_ymsl" , " side = " , side ) 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Ymsl( sklv )
	local Cooldown = 5000
	return Cooldown
end

function SkillPre_Ymsl ( sklv )										--����"Ұ������"�ļ���ǰ��׼��
end 

function SkillSp_Ymsl ( sklv )										--����"Ұ������"��sp���Ĺ�ʽ
	local sp_reduce = 10 + sklv * 1  
	return sp_reduce 
end 


function Skill_Ymsl_Begin ( role , sklv ) 
	local sp = Sp( role ) 
	local sp_reduce = SkillSp_Ymsl ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		--LG("skill_ymsl", "function Skill_Atk_Ymsl : ", "sp�����޷�ʹ��Ұ������" , "\n" ) 
		return 
	end 
end 

function Skill_Ymsl_End ( ATKER , DEFER , sklv ) 
	local hp = Hp( DEFER ) 
	--LG("ymsl" , "enter defer_mod " ) 
	atk_rad = 1.5+sklv*0.1 
	hpdmg = Atk_Raise ( atk_rad , ATKER , DEFER )
	Hp_Endure_Dmg ( DEFER , hpdmg )  
	--LG( "Ymsl", "Ұ�����Ѽ��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
 end


--���ܴ�����������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillArea_Circle_Dzy ( sklv )									--���ܡ�������"�ļ�������ʽ
	local side = 300 + math.floor ( sklv * 30 ) 
	SetSkillRange ( 4 , side )   
end 

function SkillPre_Dzy ( sklv )										--����"������"�ļ���ǰ��׼��
end 

function SkillCooldown_Dzy( sklv )
	local Cooldown = 10000
	return Cooldown
end

function SkillSp_Dzy ( sklv )										--����"������"��sp���Ĺ�ʽ
	local sp_reduce = 30 + sklv * 1 
	return sp_reduce 
end 


function Skill_Dzy_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Dzy (sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Dzy_End ( ATKER , DEFER , sklv ) 
	local dmg = ( -1 ) * math.floor(10 + 15 * sklv + math.floor ( Sta(ATKER)*0.5     )  )
	Hp_Endure_Dmg ( DEFER , dmg )  
	--LG( "Dzy", "���������ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
end 


--���ܴ�ظ�������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillArea_Circle_Dhfs ( sklv )									--���ܡ���ظ���"�ļ�������ʽ
	local side = 300 + math.floor ( sklv * 30 ) 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Dhfs( sklv )
	local Cooldown = 5000
	return Cooldown
end

function SkillPre_Dhfs ( sklv )										--����"��ظ���"�ļ���ǰ��׼��
end 

function SkillSp_Dhfs ( sklv )										--����"��ظ���"��sp���Ĺ�ʽ
	local sp_reduce = 15 + math.floor ( sklv*0.5 ) 
	return sp_reduce 
end 


function Skill_Dhfs_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Dhfs (sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Dhfs_End ( ATKER , DEFER , sklv ) 
		dmg = ( -1 ) * ( 5 + sklv * 3  ) 
		Hp_Endure_Dmg ( DEFER , dmg )  
		Rem_State_Unnormal ( DEFER ) 
		--LG( "Hfs", "��ظ������ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
end 


--���ܱ��ǳ��������������������������������������������������������������������������������������������������������������������������������������

function SkillArea_Line_Bkcj ( sklv )										--����"���ǳ��"�ļ�������ʽ
	local lenth = 500 + sklv * 30  
	local width = 100 + sklv * 10 
	SetSkillRange ( 1 , lenth , width  )  
end

function SkillCooldown_Bkcj( sklv )
	local Cooldown = 7000 - sklv * 500
	return Cooldown
end

function SkillSp_Bkcj ( sklv )										
	local sp_reduce = 20+ sklv * 3   
	return sp_reduce 
end


function SkillEnergy_Bkcj ( sklv )										
	local energy_reduce = math.floor ( 3 + sklv * 0.5 )    
	return energy_reduce 
end 

function Skill_Bkcj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Bkcj ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Bkcj_End ( ATKER , DEFER , sklv ) 
	local sta_atk= Sta ( ATKER ) 
	local sta_def = Sta ( DEFER ) 
	local AddStateLv = 0
	AddStateLv = GetChaStateLv ( ATKER , STATE_MLCH ) 

	local dmg = math.floor( 200 + sklv*30 +sta_atk*6 )*1.1 

	local map_name_DEFER = GetChaMapName ( DEFER )
	local agi_atker = Agi(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then


			dmg = math.floor(MAGIC_Atk_Dmg(ATKER,DEFER)+sklv*200)
			local rate =math.random(1,200)

				if rate >= Con(DEFER) then
					local statetime = math.floor(sklv/4+1)
					local statelv = sklv
					AddState ( ATKER , DEFER , STATE_XY , statelv , statetime ) 
				end
			end
		end


	local dmg_fin = Cuihua_Mofa ( dmg , AddStateLv ) 
	local dmg_ElfSkill = ElfSkill_MagicAtk ( dmg , ATKER ) 
	dmg_fin = dmg_fin + dmg_ElfSkill
	local ZSExp = GetChaAttr( ATKER , ATTR_CSAILEXP )
	if ZSExp > 0 and ZSExp < 100 then
		dmg_fin = dmg_fin * 1.055
	end
	if ZSExp >= 100 and ZSExp < 12100 then
		dmg_fin = dmg_fin * ( 1.05 + math.floor( math.pow( (ZSExp / 100) , 0.5 )) * 0.005)
	end
	Hp_Endure_Dmg ( DEFER , dmg_fin ) 
	if IsPlayer(DEFER) == 1 and IsPlayer(ATKER) == 1 then
		CALCULATE_SKILLEFFECT_LUA_000086 = GetResString("CALCULATE_SKILLEFFECT_LUA_000086")
		SkillLog(ATKER,DEFER,dmg_fin,CALCULATE_SKILLEFFECT_LUA_000086,sklv)
	end

			
end 

--����˳�硪������������������������������������������������������������������������������������������������������������������

function SkillArea_Circle_Sf ( sklv )										--����"˳��"�ļ�������ʽ
	local side = 1000  
	SetSkillRange ( 3 , side  )  
end

function SkillCooldown_Sf( sklv )
	local Cooldown = 10000
	return Cooldown
end

function SkillSp_Sf ( sklv )										
	local sp_reduce = 20+ sklv * 3   
	return sp_reduce 
end


function SkillEnergy_Sf ( sklv )										
	local energy_reduce = math.floor ( 3 + sklv * 0.5 )    
	return energy_reduce 
end 

function Skill_Sf_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Sf ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Sf_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 150 + sklv * 10 
	AddState ( ATKER , DEFER , STATE_SF , statelv , statetime ) 
		
end 

function State_Sf_Add ( role , statelv ) 
	local mspdsa_dif = 0.05 + statelv * 0.01    
	local mspdsa = ( MspdSa ( role ) + mspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 

function State_Sf_Rem ( role , statelv ) 
	local mspdsa_dif = 0.05 + statelv * 0.01    
	local mspdsa = ( MspdSa ( role ) - mspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role) 
end 












--����ȼ�յ�������������������������������������������������������������������������������������������������������������������������������������������������


function SkillPre_Rsd ( sklv )														--����"ȼ�յ�"�ļ���ǰ��׼��
end 

function SkillArea_Square_Rsd ( sklv )												--���ܡ�ȼ�յ�"�ļ�������ʽ
	local side = 250 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Rsd( sklv )
	local Cooldown = 15000
	return Cooldown
end

function SkillArea_State_Rsd ( sklv )										
	local statetime = 10 
	local statelv = sklv 
	--LG("SkillPre_Rsd" , " fucntion SkillPre_Rsd :" , " statelv = " , statelv , "statetime " , statetime ) 
	SetRangeState ( STATE_RS , statelv  , statetime ) 									--���ӵ��桰ȼ�ա�״̬
end 

function SkillSp_Rsd ( sklv )														--���ܡ�ȼ�յ�����sp���Ĺ�ʽ
	local sp_reduce = sklv * 2 + 15   
	return sp_reduce 
end 

function Skill_Rsd_Begin ( role , sklv )												--����"ȼ�յ�"�ļ���ʩ�Ź�ʽ
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Rsd ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		--LG("skill_Rsd", "function Skill_Atk_Rsd : ", "sp�����޷�ʹ��ȼ�յ�" , "\n" ) 
		return 
	end 
	Sp_Red ( role , sp_reduce ) 
	--LG( "Rsd", "ȼ�յ����ܵȼ� = " , sklv , "����sp���� = " , sp_reduce , '\n" ) 
end 

function Skill_Rsd_End ( ATKER , DEFER , sklv ) 
--	local hpdmg = sklv * 3 
--	local hp = GetChaAttr(DEFER) 
--	if role == DEFER then 
--		Hp_Endure_Dmg( DEFER , hpdmg ) 
--	end 
end 

function State_Rs_Add ( role , statelv ) 
	--LG("state_rs" , "function State_Rs_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local arealv = GetAreaStateLevel ( role , STATE_RS ) 
	local hp = GetChaAttr( role , ATTR_HP ) 
	local hpdmg = 10 
	if arealv >= 1 then 
		hpdmg = arealv * 3 + 30  
	end 
	Hp_Endure_Dmg ( role , hpdmg ) 
end 

function State_Rs_Rem ( role , statelv ) 
end 


function State_Rs_Tran ( statelv ) 
	return 10   
end 


--���ܳ���ȼ�յ�������������������������������������������������������������������������������������������������������������������������������������������������


function SkillPre_CJRsd ( sklv )														--����"ȼ�յ�"�ļ���ǰ��׼��
end 

function SkillArea_Square_CJRsd ( sklv )												--���ܡ�ȼ�յ�"�ļ�������ʽ
	local side = 1000 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_CJRsd( sklv )
	local Cooldown = 15000
	return Cooldown
end

function SkillArea_State_CJRsd ( sklv )										
	local statetime = 10
	local statelv = sklv 
	--LG("SkillPre_CJRsd" , " fucntion SkillPre_CJRsd :" , " statelv = " , statelv , "statetime " , statetime ) 
	SetRangeState ( STATE_RS , statelv  , statetime ) 									--���ӵ��桰ȼ�ա�״̬
end 

function SkillSp_CJRsd ( sklv )														--���ܡ�ȼ�յ�����sp���Ĺ�ʽ
---	local sp_reduce = sklv * 2 + 15   
---	return sp_reduce 
end 

function Skill_CJRsd_Begin ( role , sklv )												--����"ȼ�յ�"�ļ���ʩ�Ź�ʽ
	local sp = Sp(role) 
	local sp_reduce = SkillSp_CJRsd ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		--LG("skill_CJRsd", "function Skill_Atk_CJRsd : ", "sp�����޷�ʹ��ȼ�յ�" , "\n" ) 
		return 
	end 
	Sp_Red ( role , sp_reduce ) 
	--LG( "CJRsd", "ȼ�յ����ܵȼ� = " , sklv , "����sp���� = " , sp_reduce , '\n" ) 
end 

function Skill_CJRsd_End ( ATKER , DEFER , sklv ) 
--	local hpdmg = sklv * 3 
--	local hp = GetChaAttr(DEFER) 
--	if role == DEFER then 
--		Hp_Endure_Dmg( DEFER , hpdmg ) 
--	end 
end 

function State_CJRs_Add ( role , statelv ) 
		Notice("come State_CJRs_Add")
	--LG("state_rs" , "function State_Rs_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local arealv = GetAreaStateLevel ( role , STATE_RS ) 
	local hp = GetChaAttr( role , ATTR_HP ) 
	local hpdmg = 10 
	if arealv >= 1 then 
		hpdmg = arealv * 3000 + 30  
	end 
	Hp_Endure_Dmg ( role , hpdmg ) 
end 

function State_CJRs_Rem ( role , statelv ) 
		Notice(dead,"come State_CJRs_Rem")

end 


function State_CJRs_Tran ( statelv ) 
	return 10   
end 







--��������֮�𡪡�������������������������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Zzzh ( sklv )										
	local sp_reduce = 20   
	return sp_reduce 
end

function SkillCooldown_Zzzh( sklv )
	local Cooldown = 30000
	return Cooldown
end

function SkillArea_Square_Zzzh ( sklv )										--���ܡ�����֮��"�ļ�������ʽ
	local side = 300 
	SetSkillRange ( 3 , side ) 	
end 

function SkillArea_State_Zzzh ( sklv )										
	local statetime = 5 + sklv  * 1  
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local sta_atker = Sta(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
		if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
			if Can_Pk_Garner2 == 0 then
			 statetime =math.max(5,math.floor(sta_atker/30))+sklv
		--		Notice ( "statetime="..statetime)
			end
		end
	local statelv = sklv 
	--LG("SkillPre_Zzzh" , " fucntion SkillPre_Zzzh :" , " statelv = " , statelv , "statetime " , statetime ) 
	SetRangeState ( STATE_ZZZH , statelv  , statetime ) 									--���ӵ��桰����֮��״̬
end 

function Skill_Zzzh_Begin ( role , sklv ) 
	--LG( "skill_Zzzh", "enter function Skill_Atk_Zzzh : " , "\n" ) 
	--LG("skill_Zzzh", "function Skill_Atk_Zzzh : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_Zzzh ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		--LG("skill_zzzh", "function Skill_Atk_zzzh : ", "sp�����޷�ʹ������֮��" , "\n" ) 
		return 
	end 
	
	Sp_Red (role , sp_reduce ) 
	--LG( "Zzzh", "����֮���ܵȼ� = " , sklv , "����sp���� = " , sp_reduce , '\n" ) 
end 

function Skill_Zzzh_End ( ATKER , DEFER , sklv ) 
	--LG( "skill_zzzh", "enter function Skill_Def_Zzzh : " , "\n" ) 
	--LG("skill_zzzh", "function Skill_Def_Zzzh : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
		
end 

function State_Zzzh_Add ( role , statelv ) 
	--LG("state_Zzzh" , "function State_Zzzh_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local defsa_dif = (-1) * ( 0.1 + 0.02 * statelv ) 
	local defsa = math.floor (  (DefSa(role) + defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	ALLExAttrSet(role)  
end 



function State_Zzzh_Rem ( role , statelv ) 
	--LG("state_zzzh" , "function State_Zzzh_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local defsa_dif = (-1) * ( 0.1 + 0.02 * statelv ) 
	local defsa = math.floor (  (DefSa(role) - defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	ALLExAttrSet(role)  
end 

function  State_Zzzh_Tran ( statelv ) 
	local statetime = 20 + sklv * 2    
	return statetime 
end 

--����������ϡ���������������������������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Sdbz ( sklv )										
	local sp_reduce = 20   
	return sp_reduce 
end

function SkillCooldown_Sdbz( sklv )
	local Cooldown = 20000
	return Cooldown
end

function SkillArea_Square_Sdbz ( sklv )										--���ܡ��������"�ļ�������ʽ
	local side = 300 
	SetSkillRange ( 3 , side ) 	
end 

function SkillArea_State_Sdbz ( sklv )										
	local statetime = 5    
	local statelv = sklv 
	--LG("SkillPre_Sdbz" , " fucntion SkillPre_Sdbz :" , " statelv = " , statelv , "statetime " , statetime ) 
	SetRangeState ( STATE_SDBZ , statelv  , statetime ) 									--���ӵ��桰������ϡ�״̬
end 

function Skill_Sdbz_Begin ( role , sklv ) 
	--LG( "skill_Sdbz", "enter function Skill_Atk_Sdbz : " , "\n" ) 
	--LG("skill_Sdbz", "function Skill_Atk_Sdbz : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_Sdbz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		--LG("skill_sdbz", "function Skill_Atk_sdbz : ", "sp�����޷�ʹ���������" , "\n" ) 
		return 
	end 
	
	Sp_Red (role , sp_reduce ) 
	--LG( "Sdbz", "������ϼ��ܵȼ� = " , sklv , "����sp���� = " , sp_reduce , '\n" ) 
end 

function Skill_Sdbz_End ( ATKER , DEFER , sklv ) 
	--LG( "skill_sdbz", "enter function Skill_Def_Sdbz : " , "\n" ) 
	--LG("skill_sdbz", "function Skill_Def_Sdbz : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
end 

function State_Sdbz_Add ( role , statelv ) 
	--LG("state_Sdbz" , "function State_Sdbz_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local hitsa_dif = (-1) * (  0.02 * statelv ) 
	local hitsa = math.floor (  (HitSa(role) + hitsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( hitsa , role , ATTR_STATEC_HIT ) 
	ALLExAttrSet(role)  
end 



function State_Sdbz_Rem ( role , statelv ) 
	--LG("state_sdbz" , "function State_Sdbz_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local hitsa_dif = (-1) * (  0.02 * statelv ) 
	local hitsa = math.floor (  (HitSa(role) - hitsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( hitsa , role , ATTR_STATEC_HIT ) 
	ALLExAttrSet(role)  
end 

function  State_Sdbz_Tran ( statelv ) 
	local statetime = 30 + sklv * 3    
	return statetime 
end 

--������Ԩ���ӡ���������������������������������������������������������������������������������������������������������������������������������������������������
function SkillSp_Synz ( sklv )										
	local sp_reduce = sklv * 5 + 50  
	return sp_reduce 
end

function SkillCooldown_Synz( sklv )
	local Cooldown = 30000
	return Cooldown
end

function SkillArea_Square_Synz ( sklv )										--���ܡ���Ԩ����"�ļ�������ʽ
	local side = 500 
	SetSkillRange ( 3 , side ) 	
end 

function SkillArea_State_Synz ( sklv )										
	local statetime = 20 + sklv * 2     
	local statelv = sklv 
	--LG("SkillPre_Synz" , " fucntion SkillPre_Synz :" , " statelv = " , statelv , "statetime " , statetime ) 
	----bossʹ�ü��ܴ���
	if GetChaTypeID( ATKER ) == 985 then
		statetime = 40
		statelv = 10
	end
	----bossʹ�ü��ܴ�������

	SetRangeState ( STATE_SYNZ , statelv  , statetime ) 									--���ӵ��桰��Ԩ���ӡ�״̬
end 

function Skill_Synz_Begin ( role , sklv ) 
	--LG( "skill_Synz", "enter function Skill_Atk_Synz : " , "\n" ) 
	--LG("skill_Synz", "function Skill_Atk_Synz : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_Synz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		--LG("skill_synz", "function Skill_Atk_synz : ", "sp�����޷�ʹ���������" , "\n" ) 
		return 
	end 
	
	Sp_Red (role , sp_reduce ) 
	--LG( "Synz", "��Ԩ���Ӽ��ܵȼ� = " , sklv , "����sp���� = " , sp_reduce , '\n" ) 
end 

function Skill_Synz_End ( ATKER , DEFER , sklv ) 
	--LG( "skill_synz", "enter function Skill_Def_Synz : " , "\n" ) 
	--LG("skill_synz", "function Skill_Def_Synz : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
----------------������״̬
	CheckAttackState( ATKER , DEFER )
	GivePetState( ATKER , DEFER )
		
end 

function State_Synz_Add ( role , statelv ) 
	--LG("state_Synz" , "function State_Synz_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mspdsa_dif = (-1) * ( 0.20 + 0.015 * statelv ) 
	local mspdsa = math.floor (  (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX ) 

	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 



function State_Synz_Rem ( role , statelv ) 
	--LG("state_synz" , "function State_Synz_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mspdsa_dif = (-1) * ( 0.20 + 0.015 * statelv ) 
	local mspdsa = math.floor (  (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 

function  State_Synz_Tran ( statelv ) 
	local statetime = 3   
	return statetime 
end 


--���ܻظ���Ȫ��ʽ��������������������������������������������������������������������������������������������������������������������������
function SkillSp_Hfwq ( sklv )										
	local sp_reduce = sklv * 2 + 30  
	return sp_reduce 
end

function SkillCooldown_Hfwq( sklv )
	local Cooldown = 30000
	return Cooldown
end

function SkillArea_Square_Hfwq ( sklv )										--���ܡ��ظ���Ȫ"�ļ�������ʽ
	local side = 400 + sklv * 40 
	SetSkillRange ( 3 , side ) 	
end 

function SkillArea_State_Hfwq ( sklv )										
	local statetime = 15 + sklv * 2 
	local statelv = sklv 
	--LG("Skillarea_state_Hfwq" , " fucntion SkillArea_State_Hfwq :" , " statelv = " , statelv , "statetime " , statetime ) 
	SetRangeState ( STATE_HFWQ , statelv  , statetime ) 									--���ӵ��桰�ظ���Ȫ��״̬
end 

function Skill_Hfwq_Begin ( role , sklv ) 
	--LG( "skill_Hfwq", "enter function Skill_Atk_Hfwq : " , "\n" ) 
	--LG("skill_Hfwq", "function Skill_Atk_Hfwq : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_Hfwq ( sklv )	
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		--LG("skill_Hfwq", "function Skill_Atk_Hfwq : ", "sp�����޷�ʹ�ûظ���Ȫ" , "\n" ) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
	--LG( "Hfwq", "�ظ���Ȫ���ܵȼ� = " , sklv , "����sp���� = " , sp_reduce , '\n" ) 
end 

function Skill_Hfwq_End ( ATKER , DEFER , sklv ) 
		 
end 

function State_Hfwq_Add ( role , statelv ) 
	
	local dmg = -1 * ( 50 + statelv * 15 )
	Hp_Endure_Dmg ( role , dmg ) 
	
		local Check_namei  = CheckItem_namei ( ATKER )
		if Check_namei == 1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				  dmg =  dmg*2 
				CALCULATE_SKILLEFFECT_LUA_000087 = GetResString("CALCULATE_SKILLEFFECT_LUA_000087")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000087)
			end
		end
		
	local Check_lufei  = CheckItem_lufei ( ATKER )
		if Check_lufei == 1 then
			local Percentage = Percentage_Random ( 0.25 )
			if Percentage == 1 then
				  dmg =  dmg*2 
				CALCULATE_SKILLEFFECT_LUA_000088 = GetResString("CALCULATE_SKILLEFFECT_LUA_000088")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000088)
			end
	end

end 

function State_Hfwq_Rem ( role , statelv ) 

end 

function State_Hfwq_Tran ( statelv ) 
	return 3    
end 


--����ʥ��֮����ʽ��������������������������������������������������������������������������������������������������������������������������
function SkillSp_Syzy ( sklv )										
	local sp_reduce = 10 + sklv * 3    
	return sp_reduce 
end

function SkillCooldown_Syzy( sklv )
	local Cooldown = 5000
	return Cooldown
end

function SkillArea_Square_Syzy ( sklv )										--���ܡ�ʥ��֮��"�ļ�������ʽ
	local side = 600 + sklv * 20 
	SetSkillRange ( 3 , side ) 	
end 

function SkillArea_State_Syzy ( sklv )										
	local statetime = 90 + sklv *9   
	local statelv = sklv 
	--LG("Skillarea_state_Syzy" , " fucntion SkillArea_State_Syzy :" , " statelv = " , statelv , "statetime " , statetime ) 
	SetRangeState ( STATE_SYZY , statelv  , statetime ) 									--���ӵ��桰ʥ��֮����״̬
end 

function Skill_Syzy_Begin ( role , sklv ) 
	--LG( "skill_Syzy", "enter function Skill_Atk_Syzy : " , "\n" ) 
	--LG("skill_Syzy", "function Skill_Atk_Syzy : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Syzy ( sklv )	
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
	--LG( "Syzy", "ʥ��֮�����ܵȼ� = " , sklv , "����sp���� = " , sp_reduce , '\n" ) 
end 

function Skill_Syzy_End ( ATKER , DEFER , sklv ) 
---------------������״̬
	CheckAttackState1( ATKER , DEFER )		
		
end 

function State_Syzy_Add ( role , statelv ) 

end 

function State_Syzy_Rem ( role , statelv ) 

end 

function State_Syzy_Tran ( statelv ) 
	return 1     
end 


--�������С���������������������������������������������������������������������������������������������������������������������������������������
function SkillArea_Circle_Xw ( sklv )										--����"����"�ļ�������ʽ
	local side = 300  
	SetSkillRange ( 3 , side  )  
end

function SkillCooldown_Xw( sklv )
	local Cooldown = 10000
	return Cooldown
end

function SkillSp_Xw ( sklv )										
	local sp_reduce = 20+ sklv * 1    
	return sp_reduce 
end

function SkillArea_State_Xw ( sklv )										
	local statetime = 20 + sklv * 1    
	local statelv = sklv 
	SetRangeState ( STATE_XW , statelv  , statetime ) 									--���ӵ��桰ʥ��֮����״̬
end 


function Skill_Xw_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Xw ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Xw_End ( ATKER , DEFER , sklv ) 
		
end 

function State_Xw_Add ( role , statelv ) 
	local mspdsa_dif = 0.1 + statelv * 0.02 
	local aspdsa_dif = 0.05 + statelv * 0.01 
	local mspdsa = ( MspdSa ( cha_role ) - mspdsa_dif )  * ATTR_RADIX
	local aspdsa = ( AspdSa ( cha_role ) - aspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet( role )  
end 

function State_Xw_Rem ( role , statelv ) 
	local mspdsa_dif = 0.1 + statelv * 0.02 
	local aspdsa_dif = 0.05 + statelv * 0.01 
	local mspdsa = ( MspdSa ( cha_role ) + mspdsa_dif )  * ATTR_RADIX
	local aspdsa = ( AspdSa ( cha_role ) + aspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet( role )  
end 

function State_Xw_Tran ( statelv ) 
	return 1     
end


--������������������������������������������������������������������������������������������������������������������������������������������������
function SkillArea_Circle_Mw ( sklv )										--����"����"�ļ�������ʽ
	local side = 300 + sklv * 50  
	SetSkillRange ( 3 , side  )  
end

function SkillCooldown_Mw( sklv )
	local Cooldown = 10000
	return Cooldown
end

function SkillSp_Mw ( sklv )										
	local sp_reduce = 20+ sklv * 1    
	return sp_reduce 
end

function SkillArea_State_Mw ( sklv )										
	local statetime = 20    
	local statelv = sklv 
	SetRangeState ( STATE_MW , statelv  , statetime ) 									--���ӵ��桰ʥ��֮����״̬
end 

function SkillEnergy_Mw ( sklv )										
	local energy_reduce = math.floor ( 3 + sklv * 0.5 )    
	return energy_reduce 
end

function Skill_Mw_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Mw ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Mw_End ( ATKER , DEFER , sklv ) 
		
end 

function State_Mw_Add ( role , statelv ) 
	local mnatksa_dif = 0.05 + statelv * 0.01 
	local mxatksa_dif = 0.05 + statelv * 0.01 
	local mnatksa = ( MnatkSa ( role ) - mnatksa_dif )  * ATTR_RADIX 
	local mxatksa = ( MxatkSa ( role ) - mxatksa_dif )  * ATTR_RADIX 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet( role )  
end 

function State_Mw_Rem ( role , statelv ) 
	local mnatksa_dif = 0.05 + statelv * 0.01 
	local mxatksa_dif = 0.05 + statelv * 0.01 
	local mnatksa = ( MnatkSa ( role ) + mnatksa_dif )  * ATTR_RADIX 
	local mxatksa = ( MxatkSa ( role ) + mxatksa_dif )  * ATTR_RADIX 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet( role )  
end 

function State_Mw_Tran ( statelv ) 
	return 1     
end




--������Ļ��������������������������������������������������������������������������������������������������������������������������������������

function SkillArea_Circle_Lm ( sklv )										--����"��Ļ"�ļ�������ʽ
	local side = 300  
	SetSkillRange ( 3 , side  )  
end

function SkillCooldown_Lm( sklv )
	local Cooldown = 10000
	return Cooldown
end

function SkillSp_Lm ( sklv )										
	local sp_reduce = 20+ sklv * 1    
	return sp_reduce 
end

function SkillEnergy_Lm ( sklv )										
	local energy_reduce = math.floor ( 3 + sklv * 0.5 )    
	return energy_reduce 
end 

function SkillArea_State_Lm ( sklv )										
	local statetime = 15 + sklv * 1    
	local statelv = sklv 
	SetRangeState ( STATE_LM , statelv  , statetime ) 									--���ӵ��桰��Ļ��״̬
end 

function Skill_Lm_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Lm ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Lm_End ( ATKER , DEFER , sklv ) 
		
end 

function State_Lm_Add ( role , statelv ) 
	local dmg = 160 + statelv * 20 
	Hp_Endure_Dmg ( role , dmg ) 
end 

function State_Lm_Rem ( role , statelv ) 

end 

function State_Lm_Tran ( statelv ) 
	return 1     
end










--���ܴ�͸������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillArea_Line_Ctd ( sklv )										--����"��͸��"�ļ�������ʽ
	local lenth = 1500 + sklv * 50  
	local width = 50 
	SetSkillRange ( 1 , lenth , width  )  
end

function SkillCooldown_Ctd( sklv )
	local Cooldown = 5000
	return Cooldown
end

function SkillPre_Ctd ( sklv )										--����"��͸��"�ļ���ǰ��׼��
end 

function SkillSp_Ctd ( sklv )										--����"��͸��"��sp���Ĺ�ʽ
	local sp_reduce = 10 + sklv * 1 
	return sp_reduce 
end 



function Skill_Ctd_Begin ( role , sklv ) 
	--LG("line", "step 1 : skill_atk_ctd")
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Ctd ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Ctd_End ( ATKER , DEFER , sklv ) 
	--LG("line", "step 3 : skill_atk_ctd")
	local hp = Hp( DEFER ) 
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000089 = GetResString("CALCULATE_SKILLEFFECT_LUA_000089")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000089 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000090 = GetResString("CALCULATE_SKILLEFFECT_LUA_000090")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000090 ) 
		return 
	end 
	dmg = ( 1+sklv * 0.2  ) * Atk_Dmg ( ATKER , DEFER ) 
	Hp_Endure_Dmg ( DEFER , dmg )  
end 








--����ɢ�䵯��������������������������������������������������������������������������������������������������������������������������������������������������������


function SkillArea_Sector_Ssd ( sklv )										--���ܡ�ɢ�䵯"�ļ�������ʽ
	local radius = 600 + math.floor ( sklv * 20 ) 
	local angle = 90 + math.floor ( sklv / 5 ) * 15 
	SetSkillRange ( 2 , radius , angle  )  
end 

function SkillCooldown_Ssd( sklv )
	local Cooldown = 15000
	return Cooldown
end

function SkillPre_Ssd ( sklv )										--����"ɢ�䵯"�ļ���ǰ��׼��
end 

function SkillSp_Ssd ( sklv )										--����"ɢ�䵯"��sp���Ĺ�ʽ
	local sp_reduce = sklv * 1 + 15 
	return sp_reduce 
end 


function Skill_Ssd_Begin ( role , sklv ) 
	local sp = Sp( role ) 
	local sp_reduce = SkillSp_Ssd ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		--LG("skill_Ssd", "function Skill_Atk_Ssd : ", "sp�����޷�ʹ��ɢ�䵯" , "\n" ) 
		return 
	end 
	Sp_Red ( role , sp_reduce ) 
	--LG( "Ssd", "ɢ�䵯���ܵȼ� = " , sklv , "����sp���� = " , sp_reduce , '\n" ) 
end 

function Skill_Ssd_End ( ATKER , DEFER , sklv ) 

		atk_rad = 1.2 + sklv * 0.15 
		dmg = Atk_Raise ( atk_rad , ATKER , DEFER ) 
		Hp_Endure_Dmg ( DEFER, dmg )  
		--LG( "Ssd", "ɢ�䵯���ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
		--LG( "Ssd" , "ɢ�䵯���ܶԹ��������˺�" , "\n" ) 
end 




--��������״̬----------------------------------------------------------------------------------------------------------------------------------------------------

--����----------
function State_Larea_Tran ( statelv ) 
	return 1 
end 

function State_Larea_Add ( role , statelv ) 
	LG ( "LeiQu" , " role = " , role , " statelv = " , statelv ) 
	local role_type = IsPlayer ( role ) 
	if role_type == 0 then 
		return 
	end 
	local hp = Hp ( role ) 
	dmg = 5 + statelv * 1  
	Hp_Endure_Dmg ( role , dmg ) 
	local cha_role = TurnToCha ( role ) 
	local a = AddEquipEnergy ( cha_role , enumEQUIP_HAND1 , 29 , 50 ) 
end  

function State_Larea_Rem ( role , statelv ) 
end 

--����-----------

function State_Warea_Tran ( statelv ) 
	return 1 
end 

function State_Warea_Add ( role , statelv ) 
	local cha_role = TurnToCha ( role ) 
	local a = AddEquipEnergy ( cha_role , enumEQUIP_HAND2 , 29 , 50 ) 

--	LG ( "WuiQu" , " role = " , role , " statelv = " , statelv ) 
--	local ship_mnatksa_dif = -1 * ( 0.05+0.02 * statelv ) 
--	local ship_mnatksa = math.floor ( ( Ship_MnatkSa ( role ) + ship_mnatksa_dif ) * ATTR_RADIX ) 
--	SetCharaAttr( hrecsa , role , ATTR_BOAT_SKILLC_MNATK ) 
--	ALLExAttrSet(role)  
end 

function State_Warea_Rem ( role , statelv ) 
--	LG ( "WuiQu" , " role = " , role , " statelv = " , statelv ) 
--	local ship_mnatksa_dif = -1 * ( 0.05+0.02 * statelv ) 
--	local ship_mnatksa = math.floor ( ( Ship_MnatkSa ( role ) + ship_mnatksa_dif ) * ATTR_RADIX ) 
--	SetCharaAttr( hrecsa , role , ATTR_BOAT_SKILLC_MNATK ) 
--	ALLExAttrSet(role)  
end 

--����--------------

function State_Farea_Tran ( statelv ) 
	return 1 
end 

function State_Farea_Add ( role , statelv ) 
	local cha_role = TurnToCha ( role ) 
	local a = AddEquipEnergy ( cha_role , enumEQUIP_NECK , 29 , 50 ) 

--	LG ( "WuiQu" , " role = " , role , " statelv = " , statelv ) 
--	local ship_mnatksa_dif = -1 * ( 0.05+0.02 * statelv ) 
--	local ship_mnatksa = math.floor ( ( Ship_MnatkSa ( role ) + ship_mnatksa_dif ) * ATTR_RADIX ) 
--	SetCharaAttr( hrecsa , role , ATTR_BOAT_SKILLC_MNATK ) 
--	ALLExAttrSet(role)  
end 

function State_Farea_Rem ( role , statelv ) 
--	LG ( "WuiQu" , " role = " , role , " statelv = " , statelv ) 
--	local ship_mnatksa_dif = -1 * ( 0.05+0.02 * statelv ) 
--	local ship_mnatksa = math.floor ( ( Ship_MnatkSa ( role ) + ship_mnatksa_dif ) * ATTR_RADIX ) 
--	SetCharaAttr( hrecsa , role , ATTR_BOAT_SKILLC_MNATK ) 
--	ALLExAttrSet(role)  
end 

	
----------------���＼��cooldown����---------------------------------------------------------------------------------------------------------------
function SkillCooldown_Gwptjn( sklv )
	local Cooldown = 2500
	return Cooldown
end

function SkillCooldown_Zcmtl( sklv )
	local Cooldown = 2000
	return Cooldown
end

---------------���＼��-----------------------------------------------------------------------------------------------------------------------------


-----������Ц-------------------------------------------------

function SkillSp_Swcx ( sklv )										--����"������Ц"��sp���Ĺ�ʽ
   local sp_reduce = 50  
	return sp_reduce 
end 

function SkillCooldown_Swcx( sklv )
	local Cooldown = 6000
	return Cooldown
end

function Skill_Swzq_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Swcx ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Swcx_End ( ATKER , DEFER , sklv ) 
	
	Hp_Endure_Dmg ( DEFER , dmg )  
	local statelv = sklv 
	local statetime = 30    
	AddState ( ATKER , DEFER , STATE_SWCX , statelv , statetime )
end 

function State_Swcx_Add ( role , statelv )

end

function State_Swcx_Rem ( role , statelv )

end


----Ѫŭ------------------------------------------------------
function SkillSp_Xn ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end

function SkillCooldown_Xn( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_Xn_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Xn ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Xn_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  60    
	AddState ( ATKER , DEFER , STATE_XN , statelv , statetime )
	
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
end 


function State_Xn_Add ( role , statelv ) 
	local hpdmg = 300   
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role)  
end 

function State_Xn_Rem ( role , statelv )
			
end 

-----��̶------------------------------------------------------------------
function SkillSp_Nt ( sklv )										
	local sp_reduce = 40
	return sp_reduce 
end

function SkillCooldown_Nt( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_Nt_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Nt(sklv)  
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Nt_End ( ATKER , DEFER , sklv )  
	local statelv = sklv 
	local statetime = 60 
	local hpdmg = 3 * Atk_Dmg ( ATKER , DEFER ) 
	Hp_Endure_Dmg ( DEFER , hpdmg )  
	AddState( ATKER , DEFER , STATE_NT, statelv , statetime )
end 

function State_Nt_Add ( role , statelv ) 
	local mspdsa_dif = 0.5
	local hitsa_dif = 0.5 
	local mspdsa = math.floor ( (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX) 
	local hitsa = math.floor ( (HitSa(role) - hitsa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )
	SetCharaAttr( hitsa , role , ATTR_STATEC_HIT )
	ALLExAttrSet(role)  
end 

function State_Nt_Rem ( role , statelv ) 
	local mspdsa_dif = 0.5
	local hitsa_dif = 0.5 
	local mspdsa = math.floor ( (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX) 
	local hitsa = math.floor ( (HitSa(role) + hitsa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )
	SetCharaAttr( hitsa , role , ATTR_STATEC_HIT )
	ALLExAttrSet(role)  
	ALLExAttrSet(role)  
end 

----����--------------------------------------------------------------------
function SkillSp_DiZ ( sklv )										
	local sp_reduce = sklv * 5 + 50  
	return sp_reduce 
end

function SkillCooldown_DiZ( sklv )
	local Cooldown = 3000
	return Cooldown
end

function SkillArea_Square_DiZ ( sklv )										
	local side = 1000 
	SetSkillRange ( 4 , side ) 	
end 

function SkillArea_State_DiZ ( sklv )										
	local statetime = 20   
	local statelv = sklv 
	SetRangeState ( STATE_DIZ , statelv  , statetime ) 									
end 

function Skill_DiZ_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_DiZ ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	
	Sp_Red (role , sp_reduce ) 
end 

function Skill_DiZ_End ( ATKER , DEFER , sklv )
	local statetime = 20
	local statelv = 10
	AddState ( ATKER , DEFER , STATE_DIZ , statelv , statetime )
	AddState ( ATKER , DEFER , STATE_XY , statelv , 10 )

end 

function State_DiZ_Add ( role , statelv ) 
	local mspdsa_dif = (-1) * 0.30 
	local mspdsa = math.floor (  (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 



function State_DiZ_Rem ( role , statelv ) 
	local mspdsa_dif = (-1) * 0.30
	local mspdsa = math.floor (  (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 

function  State_DiZ_Tran ( statelv ) 
	local statetime = 10   
	return statetime 
end 

-----�׿�-------------------------------------------------------------------------------------

function SkillSp_XiK ( sklv )										
   local sp_reduce = 20 
	return sp_reduce 
end 

function SkillCooldown_Xik( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_Xik_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Xik ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Xik_End ( ATKER , DEFER , sklv ) 

	local aspd = Aspd ( ATKER )
	local dmg = 20 * Atk_Dmg ( ATKER , DEFER )   
	Hp_Endure_Dmg ( DEFER , dmg )  

	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
end 


----����-------------------------------------------------------------------------------------

function SkillSp_Biw ( sklv )										
   local sp_reduce = 50  
	return sp_reduce 
end 

function SkillCooldown_Biw( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_Biw_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Swcx ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Biw_End ( ATKER , DEFER , sklv ) 
	
	local statelv = sklv 
	local statetime =  60    
	AddState ( ATKER , DEFER , STATE_BIW , statelv , statetime )
end 

function State_Biw_Add ( role , statelv )

end

function State_Biw_Rem ( role , statelv )

end

----����--------------------------------------------------------------------

function SkillArea_Circle_Fer ( sklv )										
	local side = 1000
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Fer( sklv )
	local Cooldown = 5000
	return Cooldown
end

function SkillPre_Fer ( sklv )										
end 

function SkillSp_Fer ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end 


function Skill_Fer_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Fer ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Fer_End ( ATKER , DEFER , sklv ) 
	local hp = Hp( DEFER ) 
	dmg = 2 * Atk_Dmg ( ATKER , DEFER ) 
	Hp_Endure_Dmg ( DEFER , dmg )  
	Check_Ys_Rem ( ATKER , DEFER)						
end 

----���ܸ���------------------------------------------------------------------------------------------
function SkillSp_Fuz ( sklv )										
	local sp_reduce = 10  
	return sp_reduce 
end

function SkillCooldown_Fuz( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_Fuz_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Fuz ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Fuz_End ( ATKER , DEFER , sklv ) 

end 

--���ܺ���ͻϮ-------------------------------------------------------------------------------------------


function SkillArea_Circle_Hztx ( sklv )									
	local side = 300 
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_Hztx( sklv )
	local Cooldown = 2000
	return Cooldown
end


function SkillSp_Hztx ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end 

function Skill_Hx_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Hztx ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Hztx_End ( ATKER , DEFER , sklv ) 
	local statelv = 10 
	local statetime = 30
	AddState( ATKER , DEFER , STATE_HZCR, statelv , statetime ) 
end 

--����ˮĸ���---------------------------------------------------------------------------------------------

function SkillArea_Circle_Smdj ( sklv )										
	local side = 400  
	SetSkillRange ( 3 , side  )  
end

function SkillCooldown_Smdj( sklv )
	local Cooldown = 1000
	return Cooldown
end

function SkillSp_Smdj ( sklv )										
	local sp_reduce = 20    
	return sp_reduce 
end



function SkillArea_State_Smdj ( sklv )										
	local statetime = 25   
	local statelv = 10 
	SetRangeState ( STATE_LM , statelv  , statetime ) 									
end 

function Skill_Smdj_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_Smdj ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Smdj_End ( ATKER , DEFER , sklv ) 
end 


---������������-------------------------------------------------------------------------------------------------------



function SkillArea_Circle_Wzxf ( sklv )										
	local side = 400
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Wzxf( sklv )
	local Cooldown = 1000
	return Cooldown
end

function SkillPre_Wzxf ( sklv )										
end 

function SkillSp_Wzxf ( sklv )										
	local sp_reduce = 20 - math.floor ( sklv * 0.5 ) 
	return sp_reduce 
end 


function Skill_Wzxf_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Wzxf ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Wzxf_End ( ATKER , DEFER , sklv ) 
	local hp = Hp( DEFER ) 
	dmg = 3 * Atk_Dmg ( ATKER , DEFER ) 
	Hp_Endure_Dmg ( DEFER , dmg )  
end 



-----��������һ��----------------------------------------------------------------------------------------------

function SkillSp_Syzm ( sklv )										--����"��ͷ"��sp���Ĺ�ʽ
	local sp_reduce = sklv * 2 + 30  
	return sp_reduce 
end 

function SkillCooldown_Syzm( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_Syzm_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Syzm ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Syzm_End ( ATKER , DEFER , sklv ) 
	local Mxhp = Mxhp ( DEFER )
	local dmg = math.floor ( Mxhp / 2 )
	Hp_Endure_Dmg ( DEFER , dmg ) 

end


---��������Ա�-----------------------------------------------------------------------------------------------------

function SkillArea_Circle_Kdzb ( sklv )										
	local side = 400
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Kdzb( sklv )
	local Cooldown = 1000
	return Cooldown
end

function SkillPre_Kdzb ( sklv )										
end 

function SkillSp_Kdzb ( sklv )										
	local sp_reduce = 20 - math.floor ( sklv * 0.5 ) 
	return sp_reduce 
end 


function Skill_Kdzb_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Wzxf ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_Kdzb_End ( ATKER , DEFER , sklv ) 
	local hp = Hp( DEFER ) 
	dmg = 3 * Atk_Dmg ( ATKER , DEFER ) 
	Hp_Endure_Dmg ( DEFER , dmg )  
end 


function SkillCooldown_Sgjn1( sklv )
	local Cooldown = 6000
	return Cooldown
end

function SkillCooldown_Sgjn2( sklv )
	local Cooldown = 2500
	return Cooldown
end


--����ˮ���Ա�������������������������������������������������������������������������

function State_Slzb_Add ( role , statelv ) 
--	LG ( "bomb" , "���ˮ��Ҫը����?" ) 
--	Notice ( "���ˮ��Ҫը����?") 
	local hp = Hp ( role ) 
	if hp <= 0 then 
		RemoveState ( role , STATE_BOMB ) 
	end 
end 

function State_Slzb_Rem ( role , statelv ) 
--	LG ( "bomb" , "ˮ��Ҫը��?" ) 
--	Notice ( "ˮ��Ҫը��") 
	local x , y = GetChaPos ( role  ) 
	ChaUseSkill2 ( role , SK_BOMB , 1 , x, y ) 
	Notice ( "after use skill" ) 
	DelCha ( role ) 
	Notice ( "after delcha" ) 
end 


function SkillArea_Circle_Slzb ( sklv )										--���ܡ��Ǻ�"�ļ�������ʽ
	--LG( "skarea_lh", " enter function SkillArea_Circle_Lh : " , "sklv = " ,sklv ) 
	local side = 1200 + math.floor ( sklv * 20 ) 
	--LG( "skarea_lh" , " side = " , side ) 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Slzb( sklv )
	local Cooldown = 1000
	return Cooldown
end

function SkillPre_Slzb ( sklv )										
end 

function SkillSp_Slzb ( sklv )										
	local sp_reduce = 0 
	return sp_reduce 
end 


function Skill_Slzb_Begin ( role , sklv ) 

end 

function Skill_Slzb_End ( ATKER , DEFER , sklv ) 
	local atker_type = GetChaTypeID ( ATKER ) 
	local defer_type = GetChaTypeID ( DEFER ) 
--	LG ( "bomb" , "ˮ�����ը��" ) 

--	Notice ( "ˮ�����ը��") 
--	Notice ( "atker_type = "..atker_type) 
--	Notice ( "defer_type = "..defer_type) 
	local hp = Hp( DEFER ) 
	Notice ( "defer_hp = "..hp )
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000091 = GetResString("CALCULATE_SKILLEFFECT_LUA_000091")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000091 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000092 = GetResString("CALCULATE_SKILLEFFECT_LUA_000092")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000092 ) 
		return 
	end 
	dmg = 1500 
	Hp_Endure_Dmg ( DEFER , dmg )  
	SetCharaAttr ( -1 , ATKER , ATTR_HP ) 
--	Notice ( "ˮ��ը����") 
end 

---ʥս����״̬------------------
function State_JHKML_Add ( role , statelv ) 
	local mnatksa_dif = -0.3
	local mxatksa_dif = -0.3
	local mnatksa = math.floor ( (MnatkSa(role) + mnatksa_dif ) * ATTR_RADIX) 
	local mxatksa = math.floor ( (MxatkSa(role) + mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
end 



function State_JHKML_Rem ( role , statelv ) 
	local mnatksa_dif = -0.3
	local mxatksa_dif = -0.3
	local mnatksa = math.floor ( (MnatkSa(role) - mnatksa_dif ) * ATTR_RADIX) 
	local mxatksa = math.floor ( (MxatkSa(role) - mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
end



---PK������״̬------------------
---��ҩ��û��--------------------
function State_PKDYK_Add ( role , statelv ) 
	local mnatksa_dif = -0.8 
	local mxatksa_dif = -0.8
	local mnatksa = math.floor ( (MnatkSa(role) + mnatksa_dif ) * ATTR_RADIX) 
	local mxatksa = math.floor ( (MxatkSa(role) + mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
end 



function State_PKDYK_Rem ( role , statelv ) 
	local mnatksa_dif = -0.8
	local mxatksa_dif = -0.8
	local mnatksa = math.floor ( (MnatkSa(role) - mnatksa_dif ) * ATTR_RADIX) 
	local mxatksa = math.floor ( (MxatkSa(role) - mxatksa_dif ) * ATTR_RADIX) 
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK ) 
	ALLExAttrSet(role)  
end

---����û��-----------------------------

function State_PKLC_Add ( role , statelv ) 
	local def_dif = -200  
	local def = DefSb(role) + def_dif
	local Res_sa = ResistSa(role)
	local Res_sa_dif = -0.5
	local Res = Res_sa + Res_sa_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	SetCharaAttr( Res , role , ATTR_STATEC_PDEF )
	ALLExAttrSet(role)

end 



function State_PKLC_Rem ( role , statelv ) 
	local def_dif = -200  
	local def = DefSb(role) - def_dif
	local Res_sa = ResistSa(role)
	local Res_sa_dif = -0.5
	local Res = Res_sa - Res_sa_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	SetCharaAttr( Res , role , ATTR_STATEC_PDEF )
	ALLExAttrSet(role)
	ALLExAttrSet(role)
end 

----����������-------------------------------
function SkillSp_PKXL ( sklv ) 
	return 0 
end 

function SkillCooldown_PKXL( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_PKXL_Begin  ( role , sklv ) 
end 

function Skill_PKXL_End ( ATKER , DEFER , sklv ) 
	local i = CheckBagItem( ATKER , 4661 )
	if i <= 0 then
		CALCULATE_SKILLEFFECT_LUA_000093 = GetResString("CALCULATE_SKILLEFFECT_LUA_000093")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000093)
		return
	end
	local j = DelBagItem(ATKER,4661,1)
	if j == 1 then
		CALCULATE_SKILLEFFECT_LUA_000094 = GetResString("CALCULATE_SKILLEFFECT_LUA_000094")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000094 ) 
		local hpdmg = 200 + sklv * 20 
		local hp = Hp(DEFER) + hpdmg 
		SetCharaAttr(hp , DEFER , ATTR_HP )
	else
		CALCULATE_SKILLEFFECT_LUA_000095 = GetResString("CALCULATE_SKILLEFFECT_LUA_000095")
		LG("PK_repair",CALCULATE_SKILLEFFECT_LUA_000095)
	end
	
end 

----PK������---------------------------------

--��ţҩˮ----------------------------------
function State_PKMNYS_Add ( role ,statelv )
	local MxhpSb_dif = 1000
	local MxhpSb = MxhpSb( role ) + MxhpSb_dif
	SetCharaAttr( MxhpSb , role , ATTR_STATEV_MXHP )
	ALLExAttrSet(role)
end

function State_PKMNYS_Rem ( role , statelv )
	local MxhpSb_dif = 1000
	local MxhpSb = MxhpSb( role ) - MxhpSb_dif
	SetCharaAttr( MxhpSb , role , ATTR_STATEV_MXHP )
	ALLExAttrSet(role)
end

--ս��ҩˮ----------------------------------
function State_PKZDYS_Add ( role , statelv )
	local atksb_dif = 150
	if statelv == 1 then
		atksb_dif = 30
	end
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)
end

function State_PKZDYS_Rem ( role , statelv )
	local atksb_dif = 150
	if statelv == 1 then
		atksb_dif = 30
	end
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)
end
------��ս�� �����߹�����С�����ͷ������ĵ��߳���ʱ��15����

function State_KUANGZ_Add ( role , statelv )
	local atksb_dif = 50	
	local def_dif = 25
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	local defsb = DefSb( role ) - def_dif
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end

function State_KUANGZ_Rem ( role , statelv )
	local atksb_dif = 50	
	local def_dif = 25
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	local defsb = DefSb( role ) + def_dif
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end
--��ҩˮ----------------------------------
function State_PKKBYS_Add ( role , statelv )
	local aspd_dif = 140
	local aspdsb = ( AspdSb(role) + aspd_dif ) 
	SetCharaAttr( aspdsb , role , ATTR_STATEV_ASPD ) 
	ALLExAttrSet(role)
end

function State_PKKBYS_Rem ( role , statelv )
	local aspd_dif = 140
	local aspdsb = ( AspdSb(role) - aspd_dif ) 
	SetCharaAttr( aspdsb , role , ATTR_STATEV_ASPD ) 
	ALLExAttrSet(role)
end

--����ҩˮ--------------------------------------
function State_PKJSYS_Add ( role , statelv )
	local sta_dif = 30
	local stasb = StaSb( role ) + sta_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	ALLExAttrSet(role)
end

function State_PKJSYS_Rem ( role , statelv )
	local sta_dif = 30
	local stasb = StaSb( role ) - sta_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	ALLExAttrSet(role)
end

--ʯ��ҩˮ-------------------------------------
function State_PKSFYS_Add ( role , statelv )
	local def_dif = 150
	if statelv == 1 then
		def_dif = 30
	end
	local defsb = DefSb(role) + def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end

function State_PKSFYS_Rem ( role , statelv )
	local def_dif = 150
	if statelv == 1 then
		def_dif = 30
	end
	local defsb = DefSb(role) - def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end
----ȫ��װ�� �����߷�����С�����͹������ĵ��߳���ʱ��15����

function State_QUANS_Add ( role , statelv )
	local def_dif = 70
	local atksb_dif = 30
	local defsb = DefSb( role ) + def_dif
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)
end

function State_QUANS_Rem ( role , statelv )
	local def_dif = 70
	local atksb_dif = 30
	local defsb = DefSb( role ) - def_dif
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)
end
--��׼ҩˮ--------------------------------------
function State_PKJZYS_Add ( role , statelv )
	local hit_dif = 30
	local hitsb  = HitSb( role ) + hit_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT )
	ALLExAttrSet(role)
end

function State_PKJZYS_Rem ( role , statelv )
	local hit_dif = 30
	local hitsb  = HitSb( role ) - hit_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT )
	ALLExAttrSet(role)
end

--���ݣ�����ҩˮ��----------------------------------
function State_PKSBYS_Add ( role ,statelv )
	local Flee_dif = 10
	if statelv == 1 then
		Flee_dif = 10
	end
	local Flee = FleeSb( role ) + Flee_dif
	SetCharaAttr( Flee , role , ATTR_STATEV_FLEE )
	ALLExAttrSet(role)
end

function State_PKSBYS_Rem ( role , statelv )
	local Flee_dif = 10
	if statelv == 1 then
		Flee_dif = 10
	end
	local Flee = FleeSb( role ) - Flee_dif
	SetCharaAttr( Flee , role , ATTR_STATEV_FLEE )
	ALLExAttrSet(role)
end


--�޵�״̬---------------------------------------
function SkillCooldown_Wudiyaoshui( sklv )
	local Cooldown = 20000 
	return Cooldown
end
function Skill_Wudiyaoshui_Begin ( role , sklv ) 
		--SystemNotice( role , "Skill_Wudiyaoshui_Begin")
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local map_name = GetChaMapName ( atk_role )	
	if map_name ~=  "secretgarden" then
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000096 = GetResString("CALCULATE_SKILLEFFECT_LUA_000096")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000096 ) 
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 1860 ) --�޵�ҩˮ
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 1860 , 1 ) 
end 

function Skill_Wudiyaoshui_End( ATKER , DEFER , sklv )
		--SystemNotice( ATKER , "Skill_Wudiyaoshui_End")
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local statelv = 10
	local statetime = 5
		--SystemNotice( ATKER , "STATE_PKWD_Begin")
	AddState( ATKER , DEFER , STATE_PKWD , statelv , statetime )
		--SystemNotice( ATKER , "STATE_PKWD_End")
	local cha_name = GetChaDefaultName ( ATKER ) 
	CALCULATE_SKILLEFFECT_LUA_000097 = GetResString("CALCULATE_SKILLEFFECT_LUA_000097")
	local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000097  
	Notice ( message )
end 

function State_PKWd_Add ( role , statelv )

end

function State_PKWd_Rem ( role , statelv )

end




--ҩˮ����ǿ��

function State_YSLLQH_Add ( role , statelv )
	local str_dif = 5
	local strsb = StrSb( role ) + str_dif
	SetCharaAttr( strsb , role , ATTR_STATEV_STR )
	ALLExAttrSet(role)
end

function State_YSLLQH_Rem ( role , statelv )
	local str_dif = 5
	local strsb = StrSb( role ) - str_dif
	SetCharaAttr( strsb , role , ATTR_STATEV_STR )
	ALLExAttrSet(role)
end


--ҩˮ����ǿ��

function State_YSMJQH_Add ( role , statelv )
	local agi_dif = 5
	local agisb = AgiSb( role ) + agi_dif
	SetCharaAttr( agisb , role , ATTR_STATEV_AGI )
	ALLExAttrSet(role)
end

function State_YSMJQH_Rem ( role , statelv )
	local agi_dif = 5
	local agisb = AgiSb( role ) - agi_dif
	SetCharaAttr( agisb , role , ATTR_STATEV_AGI )
	ALLExAttrSet(role)
end

--ҩˮרעǿ��

function State_YSLQQH_Add ( role , statelv )
	local dex_dif = 5
	local dexsb = DexSb( role ) + dex_dif
	SetCharaAttr( dexsb , role , ATTR_STATEV_DEX )
	ALLExAttrSet(role)
end

function State_YSLQQH_Rem ( role , statelv )
	local dex_dif = 5
	local dexsb = DexSb( role ) - dex_dif
	SetCharaAttr( dexsb , role , ATTR_STATEV_DEX )
	ALLExAttrSet(role)
end

--ҩˮ����ǿ��

function State_YSTZQH_Add ( role , statelv )
	local con_dif = 5
	local consb = ConSb( role ) + con_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	ALLExAttrSet(role)
end

function State_YSTZQH_Rem ( role , statelv )
	local con_dif = 5
	local consb = ConSb( role ) - con_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	ALLExAttrSet(role)
end


--ҩˮ����ǿ��

function State_YSJSQH_Add ( role , statelv )
	local sta_dif = 5
	local stasb = StaSb( role ) + sta_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	ALLExAttrSet(role)
end

function State_YSJSQH_Rem ( role , statelv )
	local sta_dif = 5
	local stasb = StaSb( role ) - sta_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	ALLExAttrSet(role)
end

--ҩˮ�ٶ�ǿ��

function State_YSMspd_Add ( role , statelv )
	local mspdsa_dif = 0
	if statelv == 1 then								--����ҩˮ
		mspdsa_dif = 0.15
	end
	local mspdsa = MspdSa ( role )
	local mspdsa_fin = ( mspdsa + mspdsa_dif ) * ATTR_RADIX
	SetCharaAttr( mspdsa_fin , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)
end

function State_YSMspd_Rem ( role , statelv )
	local mspdsa_dif = 0
	if statelv == 1 then
		mspdsa_dif = 0.15
	end
	local mspdsa = MspdSa ( role )
	local mspdsa_fin = ( mspdsa - mspdsa_dif ) * ATTR_RADIX
	SetCharaAttr( mspdsa_fin , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)
end

--��װҩˮ �����������ٶ�С�����ͷ����ĵ��߳���ʱ��15����

function State_QINGZ_Add ( role , statelv )
	local mspdsa_dif = 0.3
	local def_dif = 50
	local mspdsa = MspdSa ( role )
	local mspdsa_fin = ( mspdsa + mspdsa_dif ) * ATTR_RADIX
	local defsb = DefSb( role ) - def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	SetCharaAttr( mspdsa_fin , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)
end

function State_QINGZ_Rem ( role , statelv )
	local mspdsa_dif = 0.3
	local def_dif = 50
	local mspdsa = MspdSa ( role )
	local mspdsa_fin = ( mspdsa - mspdsa_dif ) * ATTR_RADIX
	local defsb = DefSb( role ) + def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	SetCharaAttr( mspdsa_fin , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)
end

--ҩˮ��ֻ�ٶ�ǿ��

function State_YSBoatMspd_Add ( role , statelv )
	local mspdsa_dif = 0
	if statelv == 1 then								--���Ƿ�
		mspdsa_dif = 0.15
	end
	local mspdsa = ( MspdSa ( role ) + mspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)
end

function State_YSBoatMspd_Rem ( role , statelv )
	local mspdsa_dif = 0    
	if statelv == 1 then								
		mspdsa_dif = 0.15
	end
	local mspdsa = ( MspdSa ( role ) - mspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)
end


--ҩˮ��ֻ����ǿ��

function State_YSBoatDEF_Add ( role , statelv )
	local defsb_dif = 0
	if statelv == 1 then								--ǿ��װ��
		defsb_dif = 200
	end
	local defsb = ( DefSb ( role ) + defsb_dif )
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 
	ALLExAttrSet(role)
end

function State_YSBoatDEF_Rem ( role , statelv )
	local defsb_dif = 0
	if statelv == 1 then								--ǿ��װ��
		defsb_dif = 200
	end
	local defsb = ( DefSb ( role ) - defsb_dif )
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 
	ALLExAttrSet(role)
end


-- ����
function State_DengLong_Add ( role , statelv )
	local def_dif = 50
	local defsb = DefSb( role ) + def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end

function State_DengLong_Rem ( role , statelv )
	local def_dif = 50
	local defsb = DefSb( role ) - def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end

--��ʬ��������--------------------------------------
function SkillSp_JSDD ( sklv )										
	local sp_reduce = 5 
	return sp_reduce 
end

function SkillCooldown_JSDD( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_JSDD_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_JSDD ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_JSDD_End ( ATKER , DEFER , sklv ) 
	local statelv = 1 
	local statetime =  30    
	dmg = Atk_Dmg( ATKER , DEFER )					--[[������ͨ���������������˺�]]--
	sus,dmgsa = Check_MisorCrt( ATKER, DEFER )		--[[�Ƿ�miss��crt]]--
	SetSus(DEFER , sus)							--���ñ�����miss 
--	dmgsa = Check_Zmyj ( ATKER , dmgsa )		--�жϱ����˺�����
	hpdmg = math.floor( dmg*dmgsa ) 			--[[ȡ�����˺�����С�˺��е����ֵ,��miss�ͱ����˺�]]--
	Hp_Endure_Dmg( DEFER , hpdmg )					--[[�����ܻ��߿�Ѫ]]--
	local StateLv = GetChaStateLv ( DEFER , STATE_TTISW )
	if StateLv ~= 4 then	
		AddState ( ATKER , DEFER , STATE_JSDD , statelv , statetime )
	end
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
end 


function State_JSDD_Add ( role , statelv )
	if statelv == 3 then
		--ʬ��
	end
	if statelv == 4 then
		--�����ж�
	end
	local hpdmg = 100 * statelv   
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role)  
end 

function State_JSDD_Rem ( role , statelv ) 
	--LG("state_JSDD" , "function State_JSDD_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
end 

--��ʬħ������--------------------------------------
function SkillSp_JSMF ( sklv )										--����"��ʬħ������"��sp���Ĺ�ʽ
	local sp_reduce = 3 + sklv * 2   
	return sp_reduce 
end 

function SkillArea_Line_JSMF ( sklv )										--����"��ʬ�����"�ļ�������ʽ
	local lenth = 800   
	local width = 200 + sklv * 10 
	SetSkillRange ( 1 , lenth , width  )  
end


function SkillCooldown_JSMF( sklv ) 
	local Cooldown = 2000
	return Cooldown
end


function Skill_JSMF_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_JSMF ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_JSMF_End ( ATKER , DEFER , sklv ) 
	local Sta_role = Sta ( DEFER ) 

	hpdmg =  math.max ( 1 ,math.max ( 30 , math.floor ( ( 150 - Sta_role ) ) * 2.8 ) ) 
	
	Hp_Endure_Dmg ( DEFER, hpdmg )  

end 

--����ʿħ������--------------------------------------

function SkillSp_HDSMF ( sklv )										--����"����ħ������"��sp���Ĺ�ʽ
	local sp_reduce = 30 + sklv * 2   
	return sp_reduce 
end 

function SkillCooldown_HDSMF( sklv ) 
	local Cooldown = 3000 
	return Cooldown
end

function Skill_HDSMF_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_HDSMF ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_HDSMF_End ( ATKER , DEFER , sklv )
	local Sta_role = Sta ( DEFER ) 
	hpdmg =  math.max ( 1 , math.max ( 30 , ( 150 - Sta_role ) ) * 4 ) 
	Hp_Endure_Dmg ( DEFER, hpdmg )
end 
--����ħ������--------------------------------------
function SkillSp_HYMF ( sklv )										--����"����ħ������"��sp���Ĺ�ʽ
	local sp_reduce = 10 + sklv * 2   
	return sp_reduce 
end

function SkillCooldown_HYMF( sklv ) 
	local Cooldown = 3000 
	return Cooldown
end

function Skill_HYMF_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_HYMF ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_HYMF_End ( ATKER , DEFER , sklv )
	local Sta_role = Sta ( DEFER ) 
	hpdmg = math.max ( 1 ,  math.floor (  math.max ( 50 , ( 150 - Sta_role ) ) * 3.5 ) ) 
	Hp_Endure_Dmg ( DEFER, hpdmg )
end 



--�����Ȼ�--------------------------------------
--���Խ�ɫһ��ʱ���޷��ƶ����������ͷż���
function SkillSp_HYMH ( sklv )										--����"�����Ȼ�"��sp���Ĺ�ʽ
	local sp_reduce = 50 + sklv * 2   
	return sp_reduce 
end 

function SkillCooldown_HYMH( sklv ) 
	local Cooldown = 2000
	return Cooldown
end

function Skill_HYMH_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_HYMH ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

	--local cha_type = GetChaTypeID ( cha ) 

function Skill_HYMH_End ( ATKER , DEFER , sklv ) 
        local cha_type = GetChaTypeID ( DEFER )
	local statelv = sklv 
	local statetime =  6 + sklv * 1  

	if cha_type == 1 or cha_type == 2 then
		AddState ( ATKER , DEFER , STATE_HYMH , statelv , statetime ) 
		Check_Ys_Rem ( ATKER , DEFER )					--�ж��Ƿ�����
	end
end 

function State_HYMH_Add ( role , statelv ) 

end 

function State_HYMH_Rem ( role , statelv ) 

end 

--����ħ������

function SkillSp_FoxMagic ( sklv )										--����"����ħ������"��sp���Ĺ�ʽ
	local sp_reduce = 10 + sklv * 2   
	return sp_reduce 
end

function SkillCooldown_FoxMagic( sklv ) 
	local Cooldown = 3000 
	return Cooldown
end

function Skill_FoxMagic_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_FoxMagic ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_FoxMagic_End ( ATKER , DEFER , sklv )
	local Sta_role = Sta ( DEFER ) 
	hpdmg =   math.max ( 50 , ( 150 - Sta_role ) )  * 10
	Hp_Endure_Dmg ( DEFER, hpdmg )
end 


--���ɷ�Χħ������

function SkillArea_Circle_FoxSquareMagic ( sklv )										
	local side = 100 
	SetSkillRange ( 4 , side ) 	
end

function SkillCooldown_FoxSquareMagic( sklv )
	local Cooldown = 7000 - sklv * 500
	return Cooldown
end

function SkillSp_FoxSquareMagic ( sklv )										
	local sp_reduce = 20+ sklv * 3   
	return sp_reduce 
end


function Skill_FoxSquareMagic_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_FoxSquareMagic ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_FoxSquareMagic_End ( ATKER , DEFER , sklv ) 
	
	local Sta_role = Sta ( DEFER ) 
	hpdmg =  math.max( 30 , ( 150 - math.floor ( Sta_role / 2  ) ) ) * 5 + 300 
	Hp_Endure_Dmg ( DEFER, hpdmg )

end

--������ʦħ��

function SkillSp_TZJSMagic ( sklv )										--����"����ħ������"��sp���Ĺ�ʽ
	local sp_reduce = 10 + sklv * 2   
	return sp_reduce 
end

function SkillCooldown_TZJSMagic( sklv ) 
	local Cooldown = 3000 
	return Cooldown
end

function Skill_TZJSMagic_Begin ( role , sklv ) 
	local sp = Sp( role ) 
	local sp_reduce = SkillSp_TZJSMagic ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable( role )   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_TZJSMagic_End ( ATKER , DEFER , sklv )
	local Sta_role = Sta ( DEFER ) 
	hpdmg =  math.max ( 50 , ( 150 - Sta_role ) ) * 5
	Hp_Endure_Dmg ( DEFER, hpdmg )
end 

--����ħ��

function SkillArea_Circle_TZQZMagic ( sklv )										
	local side = 100 
	SetSkillRange ( 4 , side ) 	
end


function SkillSp_TZQZMagic ( sklv )										--����"����ħ������"��sp���Ĺ�ʽ
	local sp_reduce = 10 + sklv * 2   
	return sp_reduce 
end

function SkillCooldown_TZQZMagic( sklv ) 
	local Cooldown = 3000 
	return Cooldown
end

function Skill_TZQZMagic_Begin ( role , sklv ) 
	local sp = Sp( role ) 
	local sp_reduce = SkillSp_TZQZMagic ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable( role )   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_TZQZMagic_End ( ATKER , DEFER , sklv )
	local Sta_role = Sta ( DEFER ) 
	local statelv = 4
	local statetime = 15
	hpdmg =   math.max ( 50 , ( 150 - Sta_role ) )  * 5
	Hp_Endure_Dmg ( DEFER, hpdmg )
	AddState ( ATKER , DEFER , STATE_JSDD , statelv , statetime ) 

end


--����ȮХ������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_QuanX ( sklv )										
	local sp_reduce = sklv * 5 + 50  
	return sp_reduce 
end

function SkillCooldown_QuanX( sklv )
	local Cooldown = 3000
	return Cooldown
end

function SkillArea_Circle_QuanX ( sklv )										
	local side = 1000 
	SetSkillRange ( 4 , side ) 	
end 

function Skill_QuanX_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_QuanX ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	
	Sp_Red (role , sp_reduce ) 
end 

function Skill_QuanX_End ( ATKER , DEFER , sklv )
	local statetime = 5
	local statelv = 10
	AddState ( ATKER , DEFER , STATE_XY , statelv , statetime )
	local hpdmg =   200 
	Hp_Endure_Dmg ( DEFER, hpdmg )

end 

--ʬ������--------------------------------------
function SkillSp_SD ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end

function SkillCooldown_SD( sklv )
	local Cooldown = 20000
	return Cooldown
end

function Skill_SD_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_SD ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_SD_End ( ATKER , DEFER , sklv ) 
	local statelv = 3
	local statetime =  60   
	local hpdmg =   300
	Hp_Endure_Dmg ( DEFER, hpdmg )
	AddState ( ATKER , DEFER , STATE_JSDD , statelv , statetime ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
end 

--��е�ޱ�

--�ޱ���Χ

function SkillArea_Line_JXJBFW ( sklv )										--����"���ǳ��"�ļ�������ʽ
	local lenth = 500
	local width = 200
	SetSkillRange ( 1 , lenth , width  )  
end

function SkillCooldown_JXJBFW( sklv )
	local Cooldown = 2000
	return Cooldown
end

function SkillSp_JXJBFW ( sklv )										
	local sp_reduce = 20+ sklv * 3   
	return sp_reduce 
end

function Skill_JXJBFW_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_JXJBFW ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_JXJBFW_End ( ATKER , DEFER , sklv ) 

	local dmg = 150
	Hp_Endure_Dmg ( DEFER , dmg ) 
end 


--��ת�ֱ�

function SkillArea_Circle_JBXZSB ( sklv )										--���ܡ���ת�ֱ�"�ļ�������ʽ
	
	local side = 300  
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_JBXZSB( sklv )
	local Cooldown = 5000
	return Cooldown
end

function SkillPre_JBXZSB ( sklv )										--����"��ת�ֱ�"�ļ���ǰ��׼��
end 

function SkillSp_JBXZSB ( sklv )										--����"��ת�ֱ�"��sp���Ĺ�ʽ
	local sp_reduce = 20 - math.floor ( sklv * 0.5 ) 
	return sp_reduce 
end 


function Skill_JBXZSB_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_JBXZSB ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_JBXZSB_End ( ATKER , DEFER , sklv ) 
	local hp = Hp( DEFER ) 

	dmg =  Atk_Dmg ( ATKER , DEFER ) 
	Hp_Endure_Dmg ( DEFER , dmg )
	Check_Ys_Rem ( ATKER , DEFER)										--�ж��Ƿ�����
end 


--����з����

function SkillSp_CRXSF ( sklv )										--����"�����Ȼ�"��sp���Ĺ�ʽ
	local sp_reduce = 50 + sklv * 2   
	return sp_reduce 
end 

function SkillCooldown_CRXSF( sklv ) 
	local Cooldown = 2000
	return Cooldown
end

function Skill_CRXSF_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_CRXSF ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_CRXSF_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 15 
	local StateLv = GetChaStateLv ( DEFER , STATE_TTISW )
	if StateLv ~= 3 then
		AddState ( ATKER , DEFER , STATE_CRXSF , statelv , statetime ) 
	end

	Check_Ys_Rem ( ATKER , DEFER )					--�ж��Ƿ�����
end 

function State_CRXSF_Add ( role , statelv ) 

end 

function State_CRXSF_Rem ( role , statelv ) 

end

--ˮ��������

function SkillSp_SXZZZ ( sklv )										--����"�����Ȼ�"��sp���Ĺ�ʽ
	local sp_reduce = 50 + sklv * 2   
	return sp_reduce 
end 

function SkillCooldown_SXZZZ( sklv ) 
	local Cooldown = 2000
	return Cooldown
end

function Skill_SXZZZ_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_SXZZZ ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_SXZZZ_End ( ATKER , DEFER , sklv ) 
	local statelv = 10
	local statetime = 180
	local StateLv = GetChaStateLv ( DEFER , STATE_TTISW )
	if StateLv ~= 2 then
		AddState ( ATKER , DEFER , STATE_ZZZH , statelv , statetime )
	end
	Check_Ys_Rem ( ATKER , DEFER )					--�ж��Ƿ�����
end 


--С��������

function SkillSp_XBLBD ( sklv )										--����"�����Ȼ�"��sp���Ĺ�ʽ
	local sp_reduce = 50 + sklv * 2   
	return sp_reduce 
end 

function SkillCooldown_XBLBD( sklv ) 
	local Cooldown = 2000
	return Cooldown
end

function Skill_XBLBD_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_XBLBD ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_XBLBD_End ( ATKER , DEFER , sklv ) 
	local statelv = 5
	local statetime = 180 
	local StateLv = GetChaStateLv ( DEFER , STATE_TTISW )
	if StateLv ~= 1 then
		AddState ( ATKER , DEFER , STATE_BDJ , statelv , statetime )
	end
	Check_Ys_Rem ( ATKER , DEFER )					--�ж��Ƿ�����
end 




--��������--------------------------------------

function SkillSp_BLGJ ( sklv )										--����"��������"��sp���Ĺ�ʽ
   local sp_reduce = 15   
	return sp_reduce 
end 

function SkillArea_Sector_BLGJ ( sklv )										--����"��������"�ļ�������ʽ
	local angle = 120  
	local radius = 800 
	SetSkillRange ( 2 , radius , angle  )  
end

function SkillCooldown_BLGJ( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_BLGJ_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_BLGJ ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_BLGJ_End ( ATKER , DEFER , sklv ) 
	
	local hpdmg = 1.5 * Atk_Dmg ( ATKER , DEFER ) 
	Hp_Endure_Dmg ( DEFER , hpdmg )
	
end 


--��������

function SkillArea_Circle_BHSD ( sklv )										--���ܡ���������"�ļ�������ʽ
	
	local side = 300
	SetSkillRange ( 4 , side )   
end

function SkillSp_BHSD ( sklv )	
	local sp_reduce = 20   
	return sp_reduce 
end 

function SkillCooldown_BHSD( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_BHSD_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_BHSD ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 


function Skill_BHSD_End ( ATKER , DEFER , sklv ) 
	local statelv = 10 
	local statetime = 15 
	AddState ( ATKER , DEFER , STATE_BDJ , statelv , statetime )
	local hpdmg = 500 
	Hp_Endure_Dmg ( DEFER , hpdmg )
	
end

--�����־�--------------------------------------

function SkillSp_HLKJ ( sklv )	
	local sp_reduce = 200
	return sp_reduce 
end 

function SkillCooldown_HLKJ( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_HLKJ_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_HLKJ ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 


function Skill_HLKJ_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 30 
	AddState ( ATKER , DEFER , STATE_HLKJ , statelv , statetime ) 
	
end 


function State_HLKJ_Add ( role , statelv ) 
	--�����ƶ�
end 


function State_HLKJ_Rem ( role , statelv ) 
end 


--������Ϣ

function SkillSp_BlackDrgDeadHit ( sklv )										--����"��������"��sp���Ĺ�ʽ
   local sp_reduce = 15   
	return sp_reduce 
end 

function SkillArea_Sector_BlackDrgDeadHit ( sklv )										--����"��������"�ļ�������ʽ
	local angle = 120  
	local radius = 600
	SetSkillRange ( 2 , radius , angle  )  
end

function SkillCooldown_BlackDrgDeadHit( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_BlackDrgDeadHit_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_BlackDrgDeadHit ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_BlackDrgDeadHit_End ( ATKER , DEFER , sklv ) 
	local hpdmg = 1.5 * Atk_Dmg ( ATKER , DEFER ) 
	Hp_Endure_Dmg ( DEFER , hpdmg )
	
end 


---��������-----------------------------------


function SkillArea_Circle_HLLM ( sklv )										
	local side = 500
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_HLLM( sklv )
	local Cooldown = 1000
	return Cooldown
end

function SkillPre_HLLM ( sklv )										
end 

function SkillSp_HLLM ( sklv )										
	local sp_reduce = 20 - math.floor ( sklv * 0.5 ) 
	return sp_reduce 
end 


function Skill_HLLM_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_HLLM ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_HLLM_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 120 
	AddState ( ATKER , DEFER , STATE_HLLM , statelv , statetime ) 
	
end 

function State_HLLM_Add ( role , statelv ) 
	local mxatksa_dif = 0.5
	local mnatksa_dif = 0.5
	local mxatksa = ( MxatkSa(role) - mxatksa_dif ) 
	local mnatksa = ( MnatkSa(role) - mnatksa_dif ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK )
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK )
	ALLExAttrSet(role)  
end 

function State_HLLM_Rem ( role , statelv ) 
	local mxatksa_dif = 0.5
	local mnatksa_dif = 0.5
	local mxatksa = ( MxatkSa(role) + mxatksa_dif ) 
	local mnatksa = ( MnatkSa(role) + mnatksa_dif ) 
	SetCharaAttr( mxatksa , role , ATTR_STATEC_MXATK )
	SetCharaAttr( mnatksa , role , ATTR_STATEC_MNATK )
	ALLExAttrSet(role)
end

--������������

function SkillArea_Circle_BlackDrgWing ( sklv )										
	local side = 3000
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_BlackDrgWing( sklv )
	local Cooldown = 1000
	return Cooldown
end

function SkillPre_BlackDrgWing ( sklv )										
end 

function SkillSp_BlackDrgWing ( sklv )										
	local sp_reduce = 20 - math.floor ( sklv * 0.5 ) 
	return sp_reduce 
end 


function Skill_BlackDrgWing_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_BlackDrgWing ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_BlackDrgWing_End ( ATKER , DEFER , sklv ) 
	local Sta_role = Sta ( DEFER ) 
	hpdmg =  math.max ( 100 , ( 150 - Sta_role ) ) * 15
	Hp_Endure_Dmg ( DEFER, hpdmg )
end 



--��������

function SkillSp_BlackHeal ( sklv )							
	local sp_reduce = 30 + sklv * 4    
	return sp_reduce 
end

function SkillCooldown_BlackHeal( sklv ) 
	local Cooldown = 7000 - sklv * 300 
	return Cooldown 
end

function Skill_BlackHeal_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_BlackHeal ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_BlackHeal_End ( ATKER , DEFER , sklv ) 
	
	local hpdmg = -50000 
	Hp_Endure_Dmg ( DEFER , hpdmg ) 

end 



--���¾���

function State_MarchElf_Add ( role , statelv )
	local def_dif = 50
	local srecsb_dif = 20  
	local defsb = DefSb( role ) + def_dif
 	local srecsb = SrecSb(role) + srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end

function State_MarchElf_Rem ( role , statelv )
	local def_dif = 50
	local srecsb_dif = 20  
	local defsb = DefSb( role ) - def_dif
 	local srecsb = SrecSb(role) - srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end

--������Х

 function SkillArea_Circle_BlackHx( sklv )									--���ܡ���Х"�ļ�������ʽ	
	local side = 5000 
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_BlackHx( sklv )
	local Cooldown = 10000
	return Cooldown
end

function Skill_BlackHx_End ( ATKER , DEFER , sklv ) 
	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 10
	AddState( ATKER , DEFER , STATE_BlackHX, statelv , statetime ) 
	dmg = 0.8 * math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
	Hp_Endure_Dmg ( DEFER , dmg) 
end 
 

function State_BlackHx_Add ( role , statelv ) 
	--LG("state_hx" , "function State_Hx_Add : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	local aspda_dif =0.3
	local aspdsa =(AspdSa(role)-aspda_dif) * ATTR_RADIX 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 



function State_BlackHx_Rem ( role , statelv ) 
	--LG("state_hx" , "function State_Hx_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	local aspda_dif =0.3
	local aspdsa =(AspdSa(role) + aspda_dif) * ATTR_RADIX 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 


--�����׻�
function SkillCooldown_BlackLj( sklv )
	local Cooldown = 10000
	return Cooldown
end

function Skill_BlackLj_End( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 3 
	local Sta_role = Sta ( DEFER ) 
	local statelv = 4
	hpdmg =1000 +  math.max ( 50 , ( 150 - Sta_role ) )  * 10
	Hp_Endure_Dmg ( DEFER, hpdmg )
	AddState ( ATKER , DEFER , STATE_HLKJ , statelv , statetime ) 
	
end 


function State_BlackLj_Add ( role , statelv ) 
	--�����ƶ�
end 


function State_BlackLj_Rem ( role , statelv ) 
end 


---������Ӱն
 function SkillCooldown_BlackHyz( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_BlackHyz_End ( ATKER , DEFER , sklv ) 
	 atk = 2 * math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
	defer_def = Def ( DEFER ) 
	defer_resist = Resist ( DEFER ) 
	dmg = Phy_Dmg ( atk, defer_def , defer_resist )
	dmg1 = math.max (20,dmg)
	Hp_Endure_Dmg ( DEFER , dmg1 )  
	 

	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
end 


----��������
 function SkillCooldown_BlackYq( sklv ) 
	local Cooldown = 10000 
	return Cooldown
end

 function Skill_BlackYq_End ( ATKER , DEFER , sklv )
	local Sta_role = Sta ( DEFER ) 
	hpdmg = 2500 +  math.max ( 50 , ( 150 - Sta_role ) )  * 20
	Hp_Endure_Dmg ( DEFER, hpdmg )
end 

-------�����ٻ�
 function SkillCooldown_BlackZh( sklv )
	local Cooldown = 1200000
	return Cooldown
end

function SkillArea_Circle_BlackZh( sklv )									
	local side = 1000 
	SetSkillRange ( 4 , side  )  
end

function Skill_BlackZh_End( ATKER , DEFER , sklv )
	local x, y = GetChaPos(ATKER)
		local x1 = x
		local x2 = x +700
		local x3 = x -700
		local y1 = y + 700
		local y2 = y - 700
		local y3 = y -700
		local new1 = CreateCha(791, x1, y1, 145, 50)
		local new2 = CreateCha(793, x2, y2, 145, 50)
		local new3 = CreateCha(794, x3, y3, 145, 50)
		SetChaLifeTime(new1, 900000)
		SetChaLifeTime(new2, 900000)
		SetChaLifeTime(new3, 900000)
end
---------------------------------���鶾��
function State_JLDS_Add ( role , statelv )
	local hpdmg = 30 * statelv   
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role)  
end 

function State_JLDS_Rem ( role , statelv ) 
	--LG("state_JSDD" , "function State_JSDD_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
end 
--���˰�����-------------------------------------
function State_CJBBT_Add ( role , statelv )
	local str = GetChaAttr( role , ATTR_STR )
	SetCharaAttr(str ,role , ATTR_STATEV_STR)
	ALLExAttrSet(role)
end
function State_CJBBT_Rem ( role , statelv )
	SetCharaAttr(0 ,role , ATTR_STATEV_STR)
	ALLExAttrSet(role)
end
--�����ɿ���-------------------------------------
function State_JRQKL_Add ( role , statelv )
	local con = GetChaAttr( role , ATTR_CON ) 
	SetCharaAttr( con , role , ATTR_STATEV_CON )
	ALLExAttrSet(role)
end
function State_JRQKL_Rem ( role , statelv )
	SetCharaAttr(0 ,role , ATTR_STATEV_CON)
	ALLExAttrSet(role)
end


--------------------����ȼ�յ�
function SkillCooldown_wlrsd( sklv ) 
	local Cooldown = 2000 
	return Cooldown
end


function Skill_wlrsd_End( ATKER , DEFER , sklv )
	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 6
	AddState( ATKER , DEFER , STATE_WLRSD, statelv , statetime ) 
	dmg = 2 * math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
	Hp_Endure_Dmg ( DEFER , dmg) 
end 

function State_wlrsd_Add ( role , statelv ) 
	local hpdmg = 60   
		Hp_Endure_Dmg ( role , hpdmg ) 
		ALLExAttrSet(role)  
end 

function State_wlrsd_Rem ( role , statelv ) 
end

----------------------------�������
function SkillCooldown_wljs( sklv )
	local Cooldown = 2000 
	return Cooldown
end

function Skill_wljs_End ( ATKER , DEFER , sklv )
	local statelv = sklv 
	local statetime = 6
	local statelv = 4
	AddState( ATKER , DEFER , STATE_WLJS, statelv , statetime ) 
 end

function  State_wljs_Add ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

function State_wljs_Rem  ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

-----------------------------------��ǹ����
function SkillCooldown_hqgj( sklv )
	local Cooldown = 3000 
	return Cooldown
end

function Skill_hqgj_End ( ATKER , DEFER , sklv ) 
	local	 atk = 1.5 * math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
	local	defer_def = Def ( DEFER ) 
	local	defer_resist = Resist ( DEFER ) 
	dmg = Phy_Dmg ( atk, defer_def , defer_resist )
	dmg1 = math.max (20,dmg)
	Hp_Endure_Dmg ( DEFER , dmg1 )  
end 


-----------------------------�������
function SkillCooldown_wljy( sklv )
	local Cooldown = 2000 
	return Cooldown
end

function Skill_wljy_End ( ATKER , DEFER , sklv )
	local statelv = sklv 
	local statetime = 3 
	local statelv = 4
	local Sta_role = Sta ( DEFER ) 
	hpdmg =400 +  math.max ( 50 , ( 150 - Sta_role ) )  * 8
	Hp_Endure_Dmg ( DEFER, hpdmg )
	AddState ( ATKER , DEFER , STATE_WLJY , statelv , statetime ) 
 end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
function State_wljy_Add ( role , statelv )

 end 

function State_wljy_Rem ( role , statelv )
 end 


--------------------------------- ������
function SkillCooldown_jgs( sklv )
	local Cooldown = 5000 
	return Cooldown
end

function Skill_jgs_End ( ATKER , DEFER , sklv )
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	local 	dmg = math.floor ( 500 +hp *0.05) 
	if dmg > 2000 then
		dmg = 2000
	end
	hp = hp - dmg 
	SetCharaAttr ( hp , DEFER , ATTR_HP ) 
end 


--------------------------------- ���鶾��
function SkillCooldown_wldb ( sklv )
	local Cooldown = 2000
	return Cooldown
end

function Skill_wldb_End ( ATKER , DEFER , sklv )
	local statelv = sklv 
	local statetime =  10  

	local	defer_def = Def ( DEFER )
	--hpdmg = 300 +  math.max ( 50 , ( 300 - defer_def ) )  * 5
	Hp_Endure_Dmg ( DEFER, hpdmg )
	AddState ( ATKER , DEFER , STATE_WLDB , statelv , statetime ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
end 


function State_wldb_Add ( role , statelv ) 
	local hpdmg = 160 
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role)  
end 

function State_wldb_Rem ( role , statelv ) 
end 


----------------------------------------- Զ�̱���
function SkillCooldown_ycbp ( ATKER , DEFER , sklv )
	local Cooldown = 2000 
	return Cooldown
end

function Skill_ycbp_End ( ATKER , DEFER , sklv )
	local Sta_role = Sta ( DEFER ) 
	hpdmg = 1000 +  math.max ( 50 , ( 150 - Sta_role ) )  * 20
	Hp_Endure_Dmg ( DEFER, hpdmg )
end 


-------------------------------------------- ��������
function SkillArea_Circle_ywgj ( sklv )										--����"����"�ļ�������ʽ
	local side = 300    
	SetSkillRange ( 3 , side  )  
end

function SkillCooldown_ywgj( sklv )
	local Cooldown = 2000
	return Cooldown
end


function SkillArea_State_ywgj ( sklv )										
	local statetime = 20    
	local statelv = sklv 
	SetRangeState ( STATE_MW , statelv  , statetime ) 									--���ӵ��桰ʥ��֮����״̬
end 


function Skill_ywgj_End ( ATKER , DEFER , sklv ) 
end 

function State_ywgj_Add ( role , statelv ) 
	local  agisb =  AgiSb( role ) 
	local hitsb_dif = 10 + math.floor (math.max(5, agisb/20) )
	local hitsb = HitSb(role) - hitsb_dif 
	SetCharaAttr ( hitsb , role , ATTR_STATEV_HIT ) 
	ALLExAttrSet(role)  
end 

function State_ywgj_Rem ( role , statelv ) 
	local  agisb =  AgiSb( role ) 
	local hitsb_dif = 10 + math.floor (math.max(5, agisb/20) )
	local hitsb = HitSb(role) + hitsb_dif 
	SetCharaAttr ( hitsb , role , ATTR_STATEV_HIT ) 
	ALLExAttrSet(role)  
end 

function State_ywgj_Tran ( statelv ) 
	return 1     
end


-----------------------------------------���ò���
function SkillCooldown_klcs ( ATKER , DEFER , sklv )
	local Cooldown = 2000 
	return Cooldown
end 

function Skill_klcs_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =6
	AddState ( ATKER , DEFER , STATE_KLCS , statelv , statetime ) 
end 


function State_klcs_Add ( role , statelv ) 
	local dmg = math.random (60,100) 
	Endure_Dmg ( role , dmg ) 
end 

function State_klcs_Rem ( role , statelv ) 
end

-----------------------------------------------------------�����ƶ�
function SkillCooldown_lyyd ( ATKER , DEFER , sklv )
	local Cooldown = 2000 
	return Cooldown
end 

function Skill_lyyd_End ( ATKER , DEFER , sklv ) 
	local x, y = GetChaPos(DEFER)
	local map_name = GetChaMapName (DEFER)
	local x = math.floor (x/100)
	local y = math.floor (y/100)
	GoTo(ATKER, x,y, map_name)
 end

-----------------------------------------------------------------���û���
function SkillCooldown_klhd ( ATKER , DEFER , sklv )
	local Cooldown = 5000 
	return Cooldown
end 

function  Skill_klhd_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =10
	AddState ( ATKER , DEFER , STATE_KLHD , statelv , statetime ) 
end 

function State_klhd_Add ( role , statelv ) 
	local defsa_dif = 0.8 
	local defsa = math.floor ( ( DefSa(role) + defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	ALLExAttrSet(role)  
end 

function State_klhd_Rem ( role , statelv ) 
	local defsa_dif = 0.8 
	local defsa = math.floor ( ( DefSa(role) - defsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	ALLExAttrSet(role)  
end 

-------------------------------------------------------- а�񹥻�
function SkillCooldown_xegj ( ATKER , DEFER , sklv )
	local Cooldown = 2000 
	return Cooldown
end 

function Skill_xegj_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local Sta_role = Sta ( DEFER ) 
	hpdmg =400 +  math.max ( 50 , ( 150 - Sta_role ) )  * 5
	Hp_Endure_Dmg ( DEFER, hpdmg )
 end


-----------------------------------------------------------�����ҿ�
function SkillCooldown_wllk ( ATKER , DEFER , sklv )
	local Cooldown = 2000 
	return Cooldown
end 

function Skill_wllk_End ( ATKER , DEFER , sklv )
	 atk =  math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
	defer_def = Def ( DEFER ) 
	defer_resist = Resist ( DEFER ) 
	dmg = Phy_Dmg ( atk, defer_def , defer_resist )
	dmg1 = math.max (20,dmg)
	Hp_Endure_Dmg ( DEFER , dmg1 ) 
end 

------------------------------------------------------------ը��Ͷ��
function SkillCooldown_zdtz ( ATKER , DEFER , sklv )
	local Cooldown = 4000 
	return Cooldown
end 

function Skill_zdtz_End ( ATKER , DEFER , sklv )
	local Sta_role = Sta ( DEFER ) 
	hpdmg =500 +  math.max ( 50 , ( 100 - Sta_role ) )  * 8
		Hp_Endure_Dmg ( DEFER, hpdmg )
end 

---------------------------------------------------------------����ŭ��


function SkillCooldown_wlnh ( ATKER , DEFER , sklv )
	local Cooldown = 2000 
	return Cooldown
end 

function  Skill_wlnh_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =10
	AddState ( ATKER , DEFER , STATE_WLNH , statelv , statetime ) 
end 

function State_wlnh_Add ( role , statelv )  
	local atksb_dif = 800	
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)
end

function State_wlnh_Rem ( role , statelv ) 
		local atksb_dif = 800	
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)
end


------------------------------------------------------------���鳰Ц
function SkillCooldown_wlcx ( ATKER , DEFER , sklv )
	local Cooldown = 2000 
	return Cooldown
end 

 function SkillArea_Circle_wlcx( sklv )									 
	local side = 2000 
	SetSkillRange ( 4 , side  )  
end 

function Skill_wlcx_End ( ATKER , DEFER , sklv )
	local statelv = sklv 
	local statetime =10
	AddState ( ATKER , DEFER , STATE_WLCX , statelv , statetime ) 
end 


function State_wlcx_Add ( role , statelv ) 
	local hitsb_dif = 30
	local hitsb = HitSb(role) - hitsb_dif  
	local flee_dif = 10
	local fleesb = FleeSb( role ) -  flee_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE )  
	
	ALLExAttrSet(role)  
end 

function State_wlcx_Rem ( role , statelv ) 
	local hitsb_dif = 30
	local hitsb = HitSb(role) + hitsb_dif  
	local flee_dif = 10
	local fleesb = FleeSb( role ) +  flee_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE )  
	
	ALLExAttrSet(role)  
end 

----------------------------------------------------------------------------- ����֮Ѫ
function SkillCooldown_zzzx ( ATKER , DEFER , sklv )
	local Cooldown = 2000 
	return Cooldown
end 

 function SkillArea_Circle_zzzx( sklv )									 
	local side = 2000 
	SetSkillRange ( 4 , side  )  
end 



function  Skill_zzzx_End ( ATKER , DEFER , sklv )
	local statelv = sklv 
	local statetime =10
	AddState ( ATKER , DEFER , STATE_ZZZX , statelv , statetime ) 
end 

function State_wlcx_Add  ( role , sklv ) 
	local hpdmg = 100
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role)  
end 

function State_wlcx_Rem  ( role , sklv ) 
	ALLExAttrSet(role)  
end 

-------------------------------------------------------------�¹�ָ�
function SkillCooldown_yghf ( ATKER , DEFER , sklv )
	local Cooldown = 2000 
	return Cooldown
end 

function Skill_yghf_End ( ATKER , DEFER , sklv )
	local hp = Hp( ATKER ) 
	local mxhp = Mxhp (ATKER)
	local hp_dif = mxhp - hp
	local hp_rec = hp_dif * 0.2
	local hp_now = hp + hp_rec
	if hp_now < 100000 then
	local	hp_rec = 100000
	end
	SetCharaAttr( hp_now , ATKER , ATTR_HP )  
end

--------------------------------------------------------------------------����ˮ��
function SkillCooldown_yghf ( ATKER , DEFER , sklv )
	local Cooldown = 2000 
	return Cooldown
end 

function Skill_wlsj_End ( ATKER , DEFER , sklv )
	 atk = 800 +  math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
	defer_def = Def ( DEFER ) 
	defer_resist = Resist ( DEFER ) 
	dmg = Phy_Dmg ( atk, defer_def , defer_resist )
	dmg1 = math.max (20,dmg)
	Hp_Endure_Dmg ( DEFER , dmg1 )  
end 

------------------------------------------------------------------ ��������
function SkillCooldown_wlxw ( ATKER , DEFER , sklv )
	local Cooldown = 2000 
	return Cooldown
end 

function SkillArea_Circle_wlxw ( sklv )										--����"����"�ļ�������ʽ
	local side = 1000  
	SetSkillRange ( 3 , side  )  
end

function SkillArea_State_wlxw ( sklv )										
	local statetime = 10    
	local statelv = sklv 
	SetRangeState ( STATE_XW , statelv  , statetime ) 									--���ӵ��桰ʥ��֮����״̬

end 

function Skill_wlxw_End ( ATKER , DEFER , sklv ) 
	
end 

function State_wlxw_Add ( role , statelv ) 
	local mspdsa_dif = 0.5 
	local aspdsa_dif = 0.3
	local mspdsa = ( MspdSa ( cha_role ) - mspdsa_dif )  * ATTR_RADIX
	local aspdsa = ( AspdSa ( cha_role ) - aspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet( role )  
end 

function State_wlxw_Rem ( role , statelv ) 
	local mspdsa_dif = 0.5 
	local aspdsa_dif = 0.3 
	local mspdsa = ( MspdSa ( cha_role ) + mspdsa_dif )  * ATTR_RADIX
	local aspdsa = ( AspdSa ( cha_role ) + aspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD ) 
	ALLExAttrSet( role )  
end 

function State_wlxw_Tran ( statelv ) 
	return 1     
end 

--------------------------------------------------------------------������Ļ
function SkillArea_Circle_wllm ( sklv )										--����"��Ļ"�ļ�������ʽ
	local side = 500  
	SetSkillRange ( 3 , side  )  
end

function SkillCooldown_wllm( sklv )
	local Cooldown = 2000
	return Cooldown
end

function SkillArea_State_wllm ( sklv )										
	local statetime = 15      
	local statelv = 7 
	SetRangeState ( STATE_LM , statelv  , statetime ) 									--���ӵ��桰��Ļ��״̬
end 

function Skill_wllm_End ( ATKER , DEFER , sklv ) 
end 

function State_Lm_Add ( role , statelv ) 
	local dmg = 160 + statelv * 20
	Hp_Endure_Dmg ( role , dmg ) 
end 

function State_Lm_Rem ( role , statelv ) 
end 

function State_Lm_Tran ( statelv ) 
	return 1     
end


---------------------------------�����ٻ�
function SkillCooldown_wlzh ( sklv )
	local Cooldown = 500000
	return Cooldown
end

function SkillArea_Circle_wlzh( sklv )									
	local side = 1000 
	SetSkillRange ( 4 , side  )  
end

function Skill_wlzh_End( ATKER , DEFER , sklv )
	local x, y = GetChaPos(ATKER)
		local x1 = x + 200
		local x2 = x + 200
		local x3 = x - 200
		local x4 = x - 200
		local y1 = y + 200
		local y2 = y - 200
		local y3 = y + 200
		local y4 = y - 200
		local new1 = CreateCha(799, x1, y1, 145, 50)
		local new2 = CreateCha(799, x2, y2, 145, 50)
		local new3 = CreateCha(799, x3, y3, 145, 50)
		local new4 = CreateCha(799, x4, y4, 145, 50)
		SetChaLifeTime(new1, 900000)
		SetChaLifeTime(new2, 900000)
		SetChaLifeTime(new3, 900000)
		SetChaLifeTime(new4, 900000)
end

-----------------------------------�����ɵ�
function SkillCooldown_wlfd( sklv )
	local Cooldown = 1000 
	return Cooldown
end

function Skill_wlfd_End ( ATKER , DEFER , sklv ) 
	local	 atk = math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
	local	defer_def = Def ( DEFER ) 
	local	defer_resist = Resist ( DEFER ) 
	dmg = Phy_Dmg ( atk, defer_def , defer_resist )
	dmg1 = math.max (20,dmg)
	Hp_Endure_Dmg ( DEFER , dmg1 )  
end 

---------------------------------����ɵ�
function SkillCooldown_jsfd ( ATKER , DEFER , sklv )
	local Cooldown = 1000 
	return Cooldown
end 

function Skill_jsfd_End ( ATKER , DEFER , sklv )
	local Sta_role = Sta ( DEFER ) 
	hpdmg =500 +  math.max ( 50 , ( 100 - Sta_role ) )  * 8
		Hp_Endure_Dmg ( DEFER, hpdmg )
end 

---Fairy Body ---
function SkillCooldown_JLFT( sklv )
	local Cooldown = 180000
	return Cooldown
end

function SkillSp_JLFT ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end 

function Skill_JLFT_BEGIN( role , sklv )					 
	local item_elf = GetChaItem(role , 2, 1)
	local item_elf_type = GetItemType ( item_elf )
	local item_elf_maxhp = GetItemAttr(item_elf,ITEMATTR_MAXURE)
	local item_elf_hp = GetItemAttr(item_elf,ITEMATTR_URE)
	local role_hp = GetChaAttr(role, ATTR_HP)
	local role_mxhp = GetChaAttr(role, ATTR_MXHP)
	local Num_JL = GetItemForgeParam ( item_elf , 1 )
	local Part1 = GetNum_Part1 ( Num_JL ) 
		
	if item_elf_type ~= 59 or Part1~=1 then
		SkillUnable(role) 
		CALCULATE_SKILLEFFECT_LUA_000098 = GetResString("CALCULATE_SKILLEFFECT_LUA_000098")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000098 )
		return 
	end

	local str = GetItemAttr( item_elf ,ITEMATTR_VAL_STR )
	local con = GetItemAttr( item_elf ,ITEMATTR_VAL_CON ) 
	local agi = GetItemAttr( item_elf ,ITEMATTR_VAL_AGI ) 
	local dex = GetItemAttr( item_elf ,ITEMATTR_VAL_DEX ) 
	local sta = GetItemAttr( item_elf ,ITEMATTR_VAL_STA ) 
	local lv_JL = str + con + agi + dex + sta

	if item_elf_hp < 5000 then
		SkillUnable ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000099 = GetResString("CALCULATE_SKILLEFFECT_LUA_000099")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000099 ) 
		return 
	end

	item_elf_hp = item_elf_hp - (6 * lv_JL / sklv) * 50
	SetItemAttr ( item_elf , ITEMATTR_URE , item_elf_hp ) 
end 

function Skill_JLFT_End ( ATKER , DEFER , sklv )
	local statelv = sklv 
	local statetime = 190 - sklv * 10 
	local item_elf = GetChaItem(ATKER , 2, 1)
	local item_elf_type = GetItemType ( item_elf )
	local Item_ID = GetItemID ( item_elf ) 

	if Item_ID==231 then
		 
		AddState( ATKER , ATKER , STATE_JLFT1, statelv , statetime ) 

	elseif Item_ID==232 then
		 
		AddState( ATKER , ATKER , STATE_JLFT2, statelv , statetime ) 

	elseif Item_ID==233 then
		 
		AddState( ATKER , ATKER , STATE_JLFT3, statelv , statetime ) 

	elseif Item_ID==235 then
		 
		AddState( ATKER , ATKER , STATE_JLFT4, statelv , statetime ) 

	elseif Item_ID==234 then
		 
		AddState( ATKER , ATKER , STATE_JLFT5, statelv , statetime ) 

	elseif Item_ID==236 then
		 
		AddState( ATKER , ATKER , STATE_JLFT6, statelv , statetime ) 

	elseif Item_ID==237 then
		 
		AddState( ATKER , ATKER , STATE_JLFT7, statelv , statetime ) 

	elseif Item_ID==681 then
		 
		AddState( ATKER , ATKER , STATE_JLFT8, statelv , statetime )

	elseif Item_ID==7126 then
		 
		AddState( ATKER , ATKER , STATE_JLFT8, statelv , statetime ) 
	end
end 

function State_JLFT_Add ( role , sklv )
	local Item_bg = GetChaItem ( role , 2 , 1  ) 
	local Get_Item_Type = GetItemType ( Item_bg ) 
		
	if Get_Item_Type == 59 then 
		local  Item_ID = GetItemID ( Item_bg )	
		local str = GetItemAttr( Item_bg ,ITEMATTR_VAL_STR )
		local con = GetItemAttr( Item_bg ,ITEMATTR_VAL_CON )
		local agi = GetItemAttr( Item_bg ,ITEMATTR_VAL_AGI )
		local dex = GetItemAttr( Item_bg ,ITEMATTR_VAL_DEX )
		local sta = GetItemAttr( Item_bg ,ITEMATTR_VAL_STA )
		local URE = GetItemAttr( Item_bg ,ITEMATTR_URE )
		local MAXURE = GetItemAttr( Item_bg ,ITEMATTR_MAXURE )
		local lv_JL = str + con + agi + dex + sta
		local Num_JL = GetItemForgeParam ( Item_bg , 1 )
		local Part1 = GetNum_Part1 ( Num_JL )
		local Part2 = GetNum_Part2 ( Num_JL )	
		local Part3 = GetNum_Part3 ( Num_JL )
		local Part4 = GetNum_Part4 ( Num_JL )
		local Part5 = GetNum_Part5 ( Num_JL )
		local Part6 = GetNum_Part6 ( Num_JL )
		local Part7 = GetNum_Part7 ( Num_JL )

		if Part1 == 1 then 
			local star = 0
			local statelv = lv_JL * 0.025 * (sklv + 1) * 0.05

			if Item_ID ==232 then 
				local star = lv_JL
				SetCharaAttr(star, role, ATTR_STATEV_STR)
			end
	
			if Item_ID ==233 then 				
				local star = lv_JL
				SetCharaAttr(star, role, ATTR_STATEV_CON)
			end

			if Item_ID ==234 then				
				local star = lv_JL
				SetCharaAttr(star, role, ATTR_STATEV_STA)
			end

			if Item_ID ==235 then 				
				local star = lv_JL
				SetCharaAttr(star, role, ATTR_STATEV_DEX)
			end

			if Item_ID ==236 then 				
				local star = lv_JL
				SetCharaAttr(star ,role , ATTR_STATEV_AGI)
			end

			if Item_ID == 231 or Item_ID == 681 then
				local star1 = GetChaAttr( role , ATTR_BMF )
				local star2 = GetChaAttr( role , ATTR_BMF )*lv_JL*0.02
				local star = star1 + star2
				SetCharaAttr(star ,role , ATTR_STATEV_MF)
			end

			if Item_ID == 681 then 
				if str~=nil and str~=0 then
					SetCharaAttr(str ,role , ATTR_STATEV_STR)
				end
				if con~=nil and con~=0 then
					SetCharaAttr(con ,role , ATTR_STATEV_CON)
				end
				if sta~=nil and sta~=0 then
					SetCharaAttr(sta ,role , ATTR_STATEV_STA)
				end
				if dex~=nil and dex~=0 then
					SetCharaAttr(dex ,role , ATTR_STATEV_DEX)
				end
				if agi~=nil and agi~=0 then
					SetCharaAttr(agi  ,role , ATTR_STATEV_AGI)
				end
			end

			if Item_ID == 7126 then
				if str~=nil and str~=0 then
					local star = str*1.2
					SetCharaAttr(star ,role , ATTR_STATEV_STR)
				end
				if con~=nil and con~=0 then
					local star = con*1.2
					SetCharaAttr(star ,role , ATTR_STATEV_CON)
				end
				if sta~=nil and sta~=0 then
					local star = sta*1.2
					SetCharaAttr(star ,role , ATTR_STATEV_STA)
				end
				if dex~=nil and dex~=0 then
					local star = dex*1.2
					SetCharaAttr(star ,role , ATTR_STATEV_DEX)
				end
				if agi~=nil and agi~=0 then
					local star = agi*1.2
					SetCharaAttr(star  ,role , ATTR_STATEV_AGI)
				end
				local star1 = GetChaAttr( role, ATTR_BMF )
				local star2 = GetChaAttr( role, ATTR_BMF ) * lv_JL * 2.5
				local star = star1 + star2
				SetCharaAttr(star ,role , ATTR_STATEV_MF)
				local pr = GetChaAttr( role, ATTR_STATEV_PDEF ) + 3
				SetCharaAttr(pr ,role , ATTR_STATEV_PDEF)
			end
		end	
	end
	ALLExAttrSet(role)
end

function State_JLFT_Rem ( role , sklv )
	SetCharaAttr(0 ,role , ATTR_STATEV_STR)
	SetCharaAttr(0 ,role , ATTR_STATEV_CON)
	SetCharaAttr(0 ,role , ATTR_STATEV_STA)
	SetCharaAttr(0 ,role , ATTR_STATEV_DEX)
	SetCharaAttr(0 ,role , ATTR_STATEV_AGI)
	SetCharaAttr(0 ,role , ATTR_STATEV_MF)
	SetCharaAttr(0 ,role , ATTR_STATEV_PDEF)
	ALLExAttrSet(role)
end


---------------------------------�����Ա�
function SkillCooldown_jlzb ( sklv )
	local Cooldown = 180000
	return Cooldown
end

function SkillArea_Circle_jlzb( sklv )									
	local side = 1500 
	SetSkillRange ( 4 , side  )  
end

function Skill_jlzb_Begin( role , sklv )	
	local item_elf = GetChaItem(role , 2, 1)			--��ȡ������2�����ָ��
	local item_elf_type = GetItemType ( item_elf )			--��ȡ������2���������
	local elf_str =  GetItemAttr( item_elf ,ITEMATTR_VAL_STR )		--����
	local elf_con =  GetItemAttr( item_elf ,ITEMATTR_VAL_CON )		--����
	local elf_agi =  GetItemAttr( item_elf ,ITEMATTR_VAL_AGI )		--רע
	local elf_dex =  GetItemAttr( item_elf ,ITEMATTR_VAL_DEX )		--����
	local elf_sta =  GetItemAttr( item_elf ,ITEMATTR_VAL_STA )		--����
	local elf_lv = elf_str + elf_con + elf_agi + elf_dex + elf_sta		--�ȼ�
	local item_elf_hp = GetItemAttr(item_elf,ITEMATTR_URE)		--��ȡ���鵱ǰhp
	local Num_JL = GetItemForgeParam ( item_elf , 1 )
	local Part1 = GetNum_Part1 ( Num_JL )	--Get Num Part 1 �� Part 7
	if item_elf_type ~= 59 or Part1~=1 then
		SkillUnable(role) 
		CALCULATE_SKILLEFFECT_LUA_000098 = GetResString("CALCULATE_SKILLEFFECT_LUA_000098")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000098 ) 
		return 
	end

	if item_elf_hp<50 then
		SkillUnable(role) 
		CALCULATE_SKILLEFFECT_LUA_000100 = GetResString("CALCULATE_SKILLEFFECT_LUA_000100")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000100 ) 
		return 
	end
	item_elf_hp = item_elf_hp - (9 *elf_lv/sklv)*50
	--if item_elf_hp<0 then
	--	item_elf_hp=0
	--end
	SetItemAttr(item_elf,ITEMATTR_URE,item_elf_hp)	
end 

function Skill_jlzb_End( ATKER , DEFER , sklv )
	local dmg_fin = 1
	local item_elf = GetChaItem(ATKER , 2, 1)
	local item_elf_type = GetItemType ( item_elf )
	local ptnRoleType = GetChaAttr(DEFER, ATTR_CHATYPE)
	if ptnRoleType == 1 or ptnRoleType ==5 or ptnRoleType == 17 then   --��ʯ����ľ���
		if item_elf_type == 59 then
			local elf_str =  GetItemAttr( item_elf ,ITEMATTR_VAL_STR )		--����
			local elf_con =  GetItemAttr( item_elf ,ITEMATTR_VAL_CON )		--����
			local elf_agi =  GetItemAttr( item_elf ,ITEMATTR_VAL_AGI  )		--רע
			local elf_dex =  GetItemAttr( item_elf ,ITEMATTR_VAL_DEX )		--����
			local elf_sta =  GetItemAttr( item_elf ,ITEMATTR_VAL_STA )		--����
			local elf_lv = elf_str + elf_con + elf_agi + elf_dex + elf_sta		--�ȼ�
			local elf_ure=GetItemAttr(item_elf,ITEMATTR_URE )*-1			 ---------ȡ��������
			local elf_maxure=GetItemAttr(item_elf,ITEMATTR_MAXURE )			 ---------ȡ��������
			
			local str = GetChaAttr( DEFER , ATTR_STR )
			local con = GetChaAttr( DEFER , ATTR_CON ) 
			local sta = GetChaAttr( DEFER , ATTR_STA )
			local agi = GetChaAttr( DEFER , ATTR_AGI)
			local dex = GetChaAttr( DEFER , ATTR_DEX )
			local Defer_Sum =  str+con+sta+agi+dex

			 dmg_fin = elf_lv * 200 - (Defer_Sum * Defer_Sum * Defer_Sum/10000)		--�˺�����
			 if dmg_fin < 0 then
				dmg_fin = 0
			 end

			if is_friend(ATKER,DEFER) ~= 1 then								--�Ѿ��ж�
				Hp_Endure_Dmg ( DEFER , dmg_fin )
			end
			
			local statetime = 20      
			local statelv = 10 		--������Ч��
			local atker_hp = GetChaAttr( ATKER , ATTR_HP ) 
	
			if dmg_fin>=atker_hp then
				AddState ( ATKER , ATKER , STATE_XY , statelv , statetime )
			else
			
			local star_hp_differ=atker_hp-dmg_fin
			SetCharaAttr(star_hp_differ,ATKER, ATTR_HP) 
			end
		end
	end
end


function State_5MBS_Add(role , sklv)
	local role_mxhp = GetChaAttr(role, ATTR_MXHP)
	Hp_Endure_Dmg ( role , role_mxhp*0.95 )
	CALCULATE_SKILLEFFECT_LUA_000101 = GetResString("CALCULATE_SKILLEFFECT_LUA_000101")
	SystemNotice (role,CALCULATE_SKILLEFFECT_LUA_000101)
end


function State_5MBS_Rem(role , sklv)

end

------------------------------------������Чͨ�ú���
function JLTX_usu(role)
	local item_elf = GetChaItem(role , 2, 1)
	local item_elf_type = GetItemType (item_elf )	
	if item_elf_type ~= 59 then				--�����û�о���
		SkillUnable(role)
		CALCULATE_SKILLEFFECT_LUA_000102 = GetResString("CALCULATE_SKILLEFFECT_LUA_000102")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000102 )  
		return 0
	end
	local item_elf_hp = GetItemAttr(item_elf,ITEMATTR_URE)		--��ȡ���鵱ǰhp
	local item_elf_endure = item_elf_hp - 100			--������Ч�������ľ�������ֵ
	if item_elf_hp<50 then
		SkillUnable(role) 
		CALCULATE_SKILLEFFECT_LUA_000100 = GetResString("CALCULATE_SKILLEFFECT_LUA_000100")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000100 ) 
		return 
	end
	local item_count = CheckBagItem ( role , 855 )		--�����û�о���Ӳ��
	if item_count <= 0 then    
		SkillUnable(role)
		CALCULATE_SKILLEFFECT_LUA_000103 = GetResString("CALCULATE_SKILLEFFECT_LUA_000103")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000103 ) 
		return 0
	end 
	
	local a = DelBagItem ( role , 855 , 1 ) 
	SetItemAttr(item_elf,ITEMATTR_URE,item_elf_endure)	--�۳�������Ӧ����
	return 1
end

------------------------------------���龫����Ч����1
function SkillCooldown_Jltx1( sklv )
	local Cooldown = 10000
	return Cooldown
end

function Skill_Jltx1_Begin ( role , sklv ) 
	local ret= JLTX_usu(role)
end 

function Skill_Jltx1_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  60    
	AddState ( ATKER , DEFER , STATE_JLTX1 , statelv , statetime ) 
end 

function State_jltx1_Add(role , sklv)

end

function State_jltx1_Rem(role , sklv)

end

------------------------------------���龫����Ч����2
function SkillCooldown_Jltx2( sklv )
	local Cooldown = 10000
	return Cooldown
end

function Skill_Jltx2_Begin ( role , sklv ) 
	local ret= JLTX_usu(role)
end 

function Skill_Jltx2_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  60    
	AddState ( ATKER , DEFER , STATE_JLTX2 , statelv , statetime ) 
end 

function State_jltx2_Add(role , sklv)

end

function State_jltx2_Rem(role , sklv)

end
------------------------------------���龫����Ч����3
function SkillCooldown_Jltx3( sklv )
	local Cooldown = 10000
	return Cooldown
end

function Skill_Jltx3_Begin ( role , sklv ) 
	local ret= JLTX_usu(role)
end 

function Skill_Jltx3_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  60   
	AddState ( ATKER , DEFER , STATE_JLTX3 , statelv , statetime ) 
end 

function State_jltx3_Add(role , sklv)

end

function State_jltx3_Rem(role , sklv)

end
------------------------------------���龫����Ч����4
function SkillCooldown_Jltx4( sklv )
	local Cooldown = 10000
	return Cooldown
end

function Skill_Jltx4_Begin ( role , sklv ) 
	local ret= JLTX_usu(role)
end 

function Skill_Jltx4_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  60    
	AddState ( ATKER , DEFER , STATE_JLTX4 , statelv , statetime ) 
end 

function State_jltx4_Add(role , sklv)

end

function State_jltx4_Rem(role , sklv)

end

------------------------------------���龫����Ч����5
function SkillCooldown_Jltx5( sklv )
	local Cooldown = 10000
	return Cooldown
end

function Skill_Jltx5_Begin ( role , sklv ) 
	local ret= JLTX_usu(role)
end 

function Skill_Jltx5_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  60    
	AddState ( ATKER , DEFER , STATE_JLTX5 , statelv , statetime ) 
end 

function State_jltx5_Add(role , sklv)

end

function State_jltx5_Rem(role , sklv)

end
------------------------------------���龫����Ч����6
function SkillCooldown_Jltx6( sklv )
	local Cooldown = 10000
	return Cooldown
end

function Skill_Jltx6_Begin ( role , sklv ) 
	local ret= JLTX_usu(role)
end 

function Skill_Jltx6_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  60    
	AddState ( ATKER , DEFER , STATE_JLTX6 , statelv , statetime ) 
end

function State_jltx6_Add(role , sklv)

end

function State_jltx6_Rem(role , sklv)

end
------------------------------------���龫����Ч����7
function SkillCooldown_Jltx7( sklv )
	local Cooldown = 10000
	return Cooldown
end

function Skill_Jltx7_Begin ( role , sklv ) 
	local ret= JLTX_usu(role)
end 

function Skill_Jltx7_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  60    
	AddState ( ATKER , DEFER , STATE_JLTX7 , statelv , statetime ) 
end 

function State_jltx7_Add(role , sklv)

end

function State_jltx7_Rem(role , sklv)

end
------------------------------------���龫����Ч����8
function SkillCooldown_Jltx8( sklv )
	local Cooldown = 10000
	return Cooldown
end

function Skill_Jltx8_Begin ( role , sklv ) 
	local ret= JLTX_usu(role)
end 

function Skill_Jltx8_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime =  60    
	AddState ( ATKER , DEFER , STATE_JLTX8 , statelv , statetime ) 
end

function State_jltx8_Add(role , sklv)

end

function State_jltx8_Rem(role , sklv)

end

------------------------------------����֮��
function State_CZZX_Add ( role , statelv )
	local str = GetChaAttr( role , ATTR_STR )
	local con = GetChaAttr( role , ATTR_CON ) 
	local sta = GetChaAttr( role , ATTR_STA )
	local agi = GetChaAttr( role , ATTR_AGI)
	local dex = GetChaAttr( role , ATTR_DEX )
	str=math.floor(str*0.3)
	con=math.floor(con*0.3)
	sta=math.floor(sta*0.3)
	agi=math.floor(agi*0.3)
	dex=math.floor(dex*0.3)
	SetCharaAttr(str ,role , ATTR_STATEV_STR)
	SetCharaAttr(con ,role , ATTR_STATEV_CON)
	SetCharaAttr(sta ,role , ATTR_STATEV_STA)
	SetCharaAttr(agi ,role , ATTR_STATEV_AGI)
	SetCharaAttr(dex ,role , ATTR_STATEV_DEX)
	ALLExAttrSet(role)
end
function State_CZZX_Rem ( role , statelv )
	SetCharaAttr(0 ,role , ATTR_STATEV_STR)
	SetCharaAttr(0 ,role , ATTR_STATEV_CON)
	SetCharaAttr(0 ,role , ATTR_STATEV_STA)
	SetCharaAttr(0 ,role , ATTR_STATEV_AGI)
	SetCharaAttr(0 ,role , ATTR_STATEV_DEX)
	ALLExAttrSet(role)
end
--������ʤ��-------------------------------------
function State_KALA_Add ( role , statelv )
	local sta = GetChaAttr( role , ATTR_STA )
	SetCharaAttr(sta ,role , ATTR_STATEV_STA)
	ALLExAttrSet(role)
end
function State_KALA_Rem ( role , statelv )
	SetCharaAttr(0 ,role , ATTR_STATEV_STA)
	ALLExAttrSet(role)
end
--+���HP��+�����ֿ���-------------------------------------
function State_XUEYU_Add ( role , statelv )
	local star=statelv*statelv*100
	local eleven=1
	if statelv==2 or statelv==3 then
		eleven=2
	elseif statelv==4 or statelv==5 then
		eleven=3
	elseif statelv==6  then
		eleven=4
	elseif statelv==7  then
		eleven=5
	elseif statelv==8 or statelv==9 then
		eleven=6
	elseif statelv==10 then
		eleven=8
	end
	SetCharaAttr(eleven ,role , ATTR_STATEV_PDEF)
	SetCharaAttr(star ,role , ATTR_STATEV_MXHP)
--	local mxhp = GetChaAttr( role , ATTR_MXHP) 
--	mxhp=mxhp+star
--	--SystemNotice (role, "mxhp=="..mxhp)
--	SetCharaAttr(mxhp, role, ATTR_HP) 
	ALLExAttrSet(role)
end
function State_XUEYU_Rem ( role , statelv )
	SetCharaAttr(0 ,role , ATTR_STATEV_PDEF)
	SetCharaAttr(0 ,role , ATTR_STATEV_MXHP)
	ALLExAttrSet(role)
end
------��ͷ��+������
function State_MANTOU_Add ( role , statelv )
	local atksb_dif = 50+(statelv-1)*100	
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)
end
function State_MANTOU_Rem ( role , statelv )
	local atksb_dif = 50+(statelv-1)*100	
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)
end
--Ů������+����-------------------------------------
function State_NVER_Add ( role , statelv )
	local sta = statelv*5
	SetCharaAttr(sta ,role , ATTR_STATEV_STA)
	ALLExAttrSet(role)
end
function State_NVER_Rem ( role , statelv )
	SetCharaAttr(0 ,role , ATTR_STATEV_STA)
	ALLExAttrSet(role)
end
--Ь֮����-------------------------------------
function Skill_xzlw_End( ATKER , DEFER , sklv )
	local dmg =math.random(15,35)
	Hp_Endure_Dmg ( DEFER , dmg )  
end 

--���
function Skill_Cooking_End( ATKER , DEFER , sklv )
end


--����
function Skill_Making_End( ATKER , DEFER , sklv )
end


--����
function Skill_Founding_End( ATKER , DEFER , sklv )
end

--�ֽ�
function Skill_Dismissing_End( ATKER , DEFER , sklv )
end




--���ܻ�Ӱն���󡪡�������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_HyzHX( sklv )
	local Cooldown = 1000
	return Cooldown
end



function Skill_HyzHX_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000031 = GetResString("CALCULATE_SKILLEFFECT_LUA_000031")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000031 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000032 = GetResString("CALCULATE_SKILLEFFECT_LUA_000032")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000032 ) 
		return 
	end 
	local aspd = Aspd ( ATKER )
	local  sklv = 10
	local dmg = ( ( 1.5 + 0.1 * sklv ) ) * (math.min(3,( math.max ( 1, math.floor( aspd / 70  ) )  ))) * Atk_Dmg ( ATKER , DEFER )   
	Hp_Endure_Dmg ( DEFER , dmg )  

	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ�����
	
end 

--���ܱ��ǳ�����󡪡���������������������������������������������������������������������������������������������������������������������������������

function SkillArea_Line_BkcjHX ( sklv )										--����"���ǳ��"�ļ�������ʽ
	local sklv = 8
	local lenth = 500 + sklv * 30  
	local width = 100 + sklv * 10 
	SetSkillRange ( 1 , lenth , width  )  
end

function SkillCooldown_BkcjHX( sklv )
	local Cooldown = 2000
	return Cooldown
end



function Skill_BkcjHX_End ( ATKER , DEFER , sklv ) 
	local sklv = 8
	local sta_atk= Sta ( ATKER ) 
	local sta_def = Sta ( DEFER ) 
	local AddStateLv = 0
	AddStateLv = GetChaStateLv ( ATKER , STATE_MLCH ) 

	local dmg = math.floor( 200 + sklv*30 +sta_atk*6 ) 
	local dmg_fin = Cuihua_Mofa ( dmg , AddStateLv ) 
	local dmg_ElfSkill = ElfSkill_MagicAtk ( dmg , ATKER ) 
	dmg_fin = dmg_fin + dmg_ElfSkill
	Hp_Endure_Dmg ( DEFER , dmg_fin ) 
end 

--���ܱ�ͷ����������������������������������������������������������������������������������������������������������������������������������������



function SkillCooldown_BtHX( sklv )
	local Cooldown = 5000
	return Cooldown
end



function Skill_BtHX_End ( ATKER , DEFER , sklv ) 
	local sklv = 10
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	local 	dmg = math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.005 * sklv) ) 
	if dmg > 2500 then
		dmg = 2500
	end
	local Check_Heilong  = CheckItem_Heilong ( ATKER )
	if Check_Heilong == 1 then
			local Percentage = Percentage_Random ( 0.1 )
			if Percentage == 1 then
				  dmg =  dmg*10 
				CALCULATE_SKILLEFFECT_LUA_000057 = GetResString("CALCULATE_SKILLEFFECT_LUA_000057")
				SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000057)
			end
	end
	hp = hp - dmg 
	SetCharaAttr ( hp , DEFER , ATTR_HP ) 
end 

--���������ײ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_XlczHX( sklv ) 
	local Cooldown = 2000
	return Cooldown
end



function Skill_XlczHX_End ( ATKER , DEFER , sklv ) 
	if ValidCha(ATKER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000065 = GetResString("CALCULATE_SKILLEFFECT_LUA_000065")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000065 ) 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		CALCULATE_SKILLEFFECT_LUA_000066 = GetResString("CALCULATE_SKILLEFFECT_LUA_000066")
		LG ( "luascript_err" , CALCULATE_SKILLEFFECT_LUA_000066 ) 
		return 
	end 
--	local atkdmg = Atk_Dmg ( ATKER , DEFER )
	local lv_atker = Lv ( TurnToCha ( ATKER ) ) 
	local lv_defer = Lv ( TurnToCha ( DEFER ) ) 
	local sta_atker = Sta(ATKER) 
	local sklv = 10
	local sta_defer = Sta(DEFER) 
	local lv_dif = math.max ( ( - 1 ) * 10 , math.min ( 10 , lv_atker - lv_defer ) ) 
	local AddStateLv = 0
	AddStateLv = GetChaStateLv ( ATKER , STATE_MLCH )

	hpdmg = math.floor (( 10 + sta_atker * 2 ) * ( 1 + sklv * 0.7 ) * ( 1 +  lv_dif * 0.025 ))
	local dmg_fin = Cuihua_Mofa ( hpdmg ,AddStateLv )
	local dmg_ElfSkill = ElfSkill_MagicAtk ( hpdmg , ATKER )
	dmg_fin = dmg_fin + dmg_ElfSkill
	Hp_Endure_Dmg ( DEFER, dmg_fin )  
--	LG( "xlcz", "�����ײ���ܵȼ� = " , sklv ,"������sta=", sta ,"��ͨ�����˺�=", atkdmg , "�����˺� = " , dmg , "\n" ) 
end 


----------------����1


function SkillCooldown_Shoulei1( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_Shoulei1_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 1135 ) --����
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 1135 , 1 ) 
end 


function Skill_Shoulei1_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 1
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	dmg = 4*math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.008 * sklv) )-1200
	if dmg > 1000 then
		dmg = 1000
	end
	Hp_Endure_Dmg ( DEFER , dmg )

--	 r1 = RemoveChaItem ( ATKER , 1135 , 1 , 2 , -1, 2 , 1  )
--	 Notice("11")
--		if r1== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
end



---------------���ⵯ1

 function SkillArea_Circle_ShanGD1( sklv )									--���ܡ���Х"�ļ�������ʽ	
	local side = 800 
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_ShanGD1( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_ShanGD1_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 1136 ) --���ⵯ1
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 1136 , 1 ) 
end 


function Skill_ShanGD1_End ( ATKER , DEFER , sklv ) 
--	r2 = RemoveChaItem ( ATKER , 1136 , 1 , 2 , -1, 2 , 1  )
--		if r2== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
--	local hp = Hp( DEFER ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 1
	local statelv = sklv 
	local statetime = sklv
	local hp_defer = Mxhp ( DEFER ) 
	if hp_defer >= 1000000 then 
		CALCULATE_SKILLEFFECT_LUA_000104 = GetResString("CALCULATE_SKILLEFFECT_LUA_000104")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000104 ) 
		return
	end 
		----bossʹ�ü��ܴ���
		if GetChaTypeID( ATKER ) == 979 then
			statetime = 8
		end

	if GetChaAIType( DEFER ) >= 21 then    --21����ΪBossAI�������Boss����boss��ͬ���趨���Ա���״̬�Ĵ���
		if BOSSXYSJ[GetChaTypeID( DEFER )] == 0 then
			CALCULATE_SKILLEFFECT_LUA_000028 = GetResString("CALCULATE_SKILLEFFECT_LUA_000028")
			Notice (CALCULATE_SKILLEFFECT_LUA_000028)
			return
		else
			BOSSXYSJ[GetChaTypeID( DEFER )] = BOSSXYSJ[GetChaTypeID( DEFER )] -1
		end
	end
		----bossʹ�ü��ܴ�������

	AddState( ATKER , DEFER , STATE_ShanGD, statelv , statetime ) 
--	dmg = 0.8 * math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
--	Hp_Endure_Dmg ( DEFER , dmg) 
end 
 

function State_ShanGD_Add ( role , statelv )

 end 

function State_ShanGD_Rem ( role , statelv )
 end 

 ------------------------����1

 function SkillArea_Circle_FuShe1( sklv )									--���ܡ���Х"�ļ�������ʽ	
	local  sklv = 1
	local side = 800 + sklv*100
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_FuShe1( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_FuShe1_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 1137 ) --����1
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 1137 , 1 ) 
end 

function Skill_FuShe1_End( ATKER , DEFER , sklv ) 
--	 r3 = RemoveChaItem ( ATKER , 1137 , 1 , 2 , -1, 2 , 1  )
--		if r3== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 1
	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 15+sklv*2
	AddState( ATKER , DEFER , STATE_ZD, statelv , statetime ) 
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	local 	dmg = 2*math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.008 * sklv) )-600
	if dmg > 500 then
		dmg = 500
	end

	Hp_Endure_Dmg ( DEFER , dmg) 
end 
 

function State_FuShe_Add ( role , statelv ) 
	local hpdmg = 20
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role)  
end 

function State_FuShe_Rem ( role , statelv ) 
end 

---------------------����̽����1

function SkillCooldown_YouL1( sklv )
	local Cooldown = 1500
	return Cooldown
end

function SkillArea_Square_YouL1 ( sklv )--���ܡ�ʥ��֮��"�ļ�������ʽ
	local  sklv = 1
	local side = 600 + sklv * 20 
	SetSkillRange ( 3 , side ) 	
end 

function SkillArea_State_YouL1 ( sklv )	
	local  sklv = 1
-- r3 = RemoveChaItem ( ATKER , 1138, 1 , 2 , -1, 2 , 1  )
--		if r3== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statetime = 40 + sklv *9   
	local statelv = sklv 
	SetRangeState ( STATE_SYZY , statelv  , statetime ) 									--���ӵ��桰ʥ��֮����״̬
end 

function Skill_YouL1_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		SkillUnable(role)   
		return 0
	end
	local item_count = CheckBagItem ( role , 1138 ) --����̽����1
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 1138 , 1 ) 
end 

function Skill_YouL1_End ( ATKER , DEFER , sklv ) 
end 

function State_Syzy_Add ( role , statelv ) 

end 

function State_Syzy_Rem ( role , statelv ) 

end 

function State_Syzy_Tran ( statelv ) 
	return 1     
end 
----------------------------��ֻ������1
function SkillCooldown_JiaSuQi( sklv )
	local Cooldown = 1500 
	return Cooldown
end

function Skill_JiaSuQi1_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 1139 ) --��ֻ������1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem (atk_role , 1139 , 1 ) 
end 

function Skill_JiaSuQi1_End ( ATKER , DEFER , sklv )
--	r5 = RemoveChaItem ( ATKER , 1139 , 1 , 2 , -1, 2 , 1  )
--		if r5== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 1
	local statelv = sklv
	local statetime = 30+sklv*20
	AddState( ATKER , DEFER , STATE_WLJS, statelv , statetime ) 
 end

function  State_wljs_Add ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

function State_wljs_Rem  ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

----------------------------��ֻ������1
function SkillCooldown_PengSheQi1( sklv )
	local Cooldown = 1500 
	return Cooldown
end

function Skill_PengSheQi1_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 1140 ) --��ֻ������1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 1140 , 1 ) 
end 

function Skill_PengSheQi1_End ( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 1
--	 r6 = RemoveChaItem ( ATKER , 1140 , 1 , 2 , -1, 2 , 1  )
--		if r6== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statetime = 3+sklv*2
	local statelv = sklv
	AddState( ATKER , DEFER , STATE_PSQ, statelv , statetime ) 
end

function  State_PengSheQi_Add ( role , statelv )
	local mspdsa_dif = 3
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

function State_PengSheQi_Rem  ( role , statelv )
	local mspdsa_dif = 3
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

--�����Ƽ�1����������������������������������������������������������������������������������������������������������������������������������������������������



function SkillCooldown_PoJiaDan( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_PoJiaDan1_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 1141 ) --��ֻ������1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 1141 , 1 ) 
end 


function Skill_PoJiaDan1_End ( ATKER , DEFER , sklv ) 
		local  sklv = 1
--	r7= RemoveChaItem ( ATKER , 1141 , 1 , 2 , -1, 2 , 1  )
--	if r7== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end	
	local statelv = sklv 
	local statetime = 10 + sklv  
	dmg = math.random ( 400 , 500 )*( 1 + sklv * 0.5 )
	Hp_Endure_Dmg ( DEFER , dmg) 
	AddState ( ATKER , DEFER , STATE_PJ , statelv , statetime ) 
	--LG("skill_Pj", "function Skill_Def_Pj : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 

	--LG( "sk_pj", "�Ƽ׼��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
end 

function State_Pj_Add ( role , statelv ) 
	--LG("state", "function State_Pj_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 
	local def_dif = 30
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end 



function State_Pj_Rem ( role , statelv ) 
--	LG("state", "function State_Pj_Rem : " ,"statelv = " , statelv , " role = ", role, "\n" ) 
	local def_dif = 30
	local def = DefSb(role) + def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 

--���е�����������������������������������������������������������������������������������������������������������������������������������������������������



function SkillCooldown_PoRenDan1( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_PoRenDan1_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 1142 ) --��ֻ������1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 1142 , 1 )  
end 


function Skill_PoRenDan1_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 1
--	 r8 = RemoveChaItem ( ATKER , 1142 , 1 , 2 , -1, 2 , 1  )
--		if r8== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statelv = sklv 
	local statetime = 10 + sklv  
	dmg = math.random ( 400 , 500 )*( 1 + sklv * 0.5 )
	Hp_Endure_Dmg ( DEFER , dmg) 
	AddState ( ATKER , DEFER , STATE_PRD , statelv , statetime ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 

end 



function State_PoRenDan_Add( role , sklv ) 
	local statelv = sklv  
	local atksb_dif = 50*sklv
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 



function State_PoRenDan_Rem( role , sklv ) 
	local statelv = sklv 
	local atksb_dif = 50*sklv
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 


-------��ֻȼ�յ�1
function SkillCooldown_RanShaoDan1( sklv ) 
	local Cooldown = 1500 
	return Cooldown
end

function Skill_RanShaoDan1_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 1143 ) --��ֻȼ�յ�1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 1143 , 1 ) 
end 

function Skill_RanShaoDan1_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 1
--	 r9 = RemoveChaItem ( ATKER , 1143 , 1 , 2 , -1, 2 , 1  )
--		if r9== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
--	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 4 + sklv*2
	AddState( ATKER , DEFER , STATE_CZRSD, statelv , statetime ) 
	dmg =  math.random ( 100 , 200 )*(1+sklv*0.5)
	Hp_Endure_Dmg ( DEFER , dmg) 
end 

function State_RanShaoDan_Add ( role , statelv ) 
	local hpdmg = 150  
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role)  
end 

function State_RanShaoDan_Rem ( role , statelv ) 
end


----------------����2


function SkillCooldown_Shoulei2( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_Shoulei2_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2719 ) --����
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2719 , 1 ) 
end 


function Skill_Shoulei2_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 2
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	dmg = 4*math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.008 * sklv) )-1200
	if dmg > 2000 then
		dmg = 2000
	end
	Hp_Endure_Dmg ( DEFER , dmg )
--	 r1 = RemoveChaItem ( ATKER , 1135 , 1 , 2 , -1, 2 , 1  )
--	 Notice("11")
--		if r1== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
end



---------------���ⵯ2

 function SkillArea_Circle_ShanGD2( sklv )									--���ܡ���Х"�ļ�������ʽ	
	local side = 800 
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_ShanGD2( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_ShanGD2_Begin ( role , sklv )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2720 ) --���ⵯ2
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2720 , 1 ) 
end 


function Skill_ShanGD2_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	r2 = RemoveChaItem ( ATKER , 1136 , 1 , 2 , -1, 2 , 1  )
--		if r2== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
--	local hp = Hp( DEFER ) 
	local  sklv = 2
	local statelv = sklv 
	local statetime = sklv
	local hp_defer = Mxhp ( DEFER ) 
	if hp_defer >= 1000000 then 
		CALCULATE_SKILLEFFECT_LUA_000104 = GetResString("CALCULATE_SKILLEFFECT_LUA_000104")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000104 ) 
		return
	end

		----bossʹ�ü��ܴ���
		if GetChaTypeID( ATKER ) == 979 then
			statetime = 8
		end

	if GetChaAIType( DEFER ) >= 21 then    --21����ΪBossAI�������Boss����boss��ͬ���趨���Ա���״̬�Ĵ���
		if BOSSXYSJ[GetChaTypeID( DEFER )] == 0 then
			CALCULATE_SKILLEFFECT_LUA_000028 = GetResString("CALCULATE_SKILLEFFECT_LUA_000028")
			Notice (CALCULATE_SKILLEFFECT_LUA_000028)
			return
		else
			BOSSXYSJ[GetChaTypeID( DEFER )] = BOSSXYSJ[GetChaTypeID( DEFER )] -1
		end
	end
		----bossʹ�ü��ܴ�������

	AddState( ATKER , DEFER , STATE_ShanGD, statelv , statetime ) 
--	dmg = 0.8 * math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
--	Hp_Endure_Dmg ( DEFER , dmg) 
end 
 

function State_ShanGD_Add ( role , statelv )

 end 

function State_ShanGD_Rem ( role , statelv )
 end 

 ------------------------����2

 function SkillArea_Circle_FuShe2( sklv )									--���ܡ���Х"�ļ�������ʽ	
	local  sklv = 2
	local side = 800 + sklv*100
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_FuShe2( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_FuShe2_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2721 ) --����2
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2721 , 1 ) 
end 

function Skill_FuShe2_End( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	 r3 = RemoveChaItem ( ATKER , 1137 , 1 , 2 , -1, 2 , 1  )
--		if r3== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local  sklv = 2
	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 15+sklv*2
	AddState( ATKER , DEFER , STATE_ZD, statelv , statetime ) 
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	local 	dmg = 2*math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.008 * sklv) )-600
	if dmg > 1000 then
		dmg = 1000
	end
	Hp_Endure_Dmg ( DEFER , dmg) 
end 
 

--function State_FuShe_Add ( role , statelv ) 
--	local hpdmg = 20
--	Hp_Endure_Dmg ( role , hpdmg ) 
--	ALLExAttrSet(role)  
--end 
--
--function State_FuShe_Rem ( role , statelv ) 
--end 

---------------------����̽����2
function SkillCooldown_YouL2( sklv )
	local Cooldown = 1500
	return Cooldown
end

function SkillArea_Square_YouL2 ( sklv )--���ܡ�ʥ��֮��"�ļ�������ʽ
	local  sklv = 2
	local side = 600 + sklv * 20 
	SetSkillRange ( 3 , side ) 	
end 

function SkillArea_State_YouL2 ( sklv )	
	local  sklv = 2
-- r3 = RemoveChaItem ( ATKER , 1138, 1 , 2 , -1, 2 , 1  )
--		if r3== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statetime = 40 + sklv *9   
	local statelv = sklv 
	SetRangeState ( STATE_SYZY , statelv  , statetime ) 									--���ӵ��桰ʥ��֮����״̬
end 

function Skill_YouL2_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		SkillUnable(role)   
		return 0
	end
	local item_count = CheckBagItem ( role , 2722 ) --����̽����2
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2722 , 1 ) 
end 

function Skill_YouL2_End ( ATKER , DEFER , sklv ) 
end 

function State_Syzy_Add ( role , statelv ) 

end 

function State_Syzy_Rem ( role , statelv ) 

end 

function State_Syzy_Tran ( statelv ) 
	return 1     
end 
----------------------------��ֻ������2
function SkillCooldown_JiaSuQi2( sklv )
	local Cooldown = 1500 
	return Cooldown
end

function Skill_JiaSuQi2_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2723 ) --��ֻ������1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2723 , 1 ) 
end 

function Skill_JiaSuQi2_End ( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	r5 = RemoveChaItem ( ATKER , 1139 , 1 , 2 , -1, 2 , 1  )
--		if r5== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local  sklv = 2
	local statelv = sklv
	local statetime = 30+sklv*20
	AddState( ATKER , DEFER , STATE_WLJS, statelv , statetime ) 
 end

function  State_wljs_Add ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

function State_wljs_Rem  ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

----------------------------��ֻ������2
function SkillCooldown_PengSheQi2( sklv )
	local Cooldown = 1500 
	return Cooldown
end

function Skill_PengSheQi2_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2724 ) --��ֻ������1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2724 , 1 ) 
end 

function Skill_PengSheQi2_End ( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 2
--	 r6 = RemoveChaItem ( ATKER , 1140 , 1 , 2 , -1, 2 , 1  )
--		if r6== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statetime = 3+sklv*2
	local statelv = sklv
	AddState( ATKER , DEFER , STATE_PSQ, statelv , statetime ) 
end

function  State_PengSheQi_Add ( role , statelv )
	local mspdsa_dif = 3
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

function State_PengSheQi_Rem  ( role , statelv )
	local mspdsa_dif = 3
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

--�����Ƽ�2����������������������������������������������������������������������������������������������������������������������������������������������������



function SkillCooldown_PoJiaDan2( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_PoJiaDan2_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2725 ) --��ֻ������1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2725 , 1 )  
end 


function Skill_PoJiaDan2_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
		local  sklv = 2
--	r7= RemoveChaItem ( ATKER , 1141 , 1 , 2 , -1, 2 , 1  )
--	if r7== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
		local statelv = sklv 
		local statetime = 10 + sklv  
		dmg = math.random ( 400 , 500 )*( 1 + sklv * 0.5 )
		Hp_Endure_Dmg ( DEFER , dmg) 
		AddState ( ATKER , DEFER , STATE_PJ , statelv , statetime ) 
		--LG("skill_Pj", "function Skill_Def_Pj : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
		Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 

		--LG( "sk_pj", "�Ƽ׼��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
end 

function State_Pj_Add ( role , statelv ) 
	--LG("state", "function State_Pj_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 
	local def_dif = 30
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end 



function State_Pj_Rem ( role , statelv ) 
--	LG("state", "function State_Pj_Rem : " ,"statelv = " , statelv , " role = ", role, "\n" ) 
	local def_dif = 30
	local def = DefSb(role) + def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 

--���е�2����������������������������������������������������������������������������������������������������������������������������������������������������



function SkillCooldown_PoRenDan2( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_PoRenDan2_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2726 ) --��ֻ������1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2726 , 1 ) 
end 


function Skill_PoRenDan2_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
		local  sklv = 2
--	 r8 = RemoveChaItem ( ATKER , 1142 , 1 , 2 , -1, 2 , 1  )
--		if r8== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
		local statelv = sklv 
		local statetime = 10 + sklv  
		dmg = math.random ( 400 , 500 )*( 1 + sklv * 0.5 )
		Hp_Endure_Dmg ( DEFER , dmg) 
		AddState ( ATKER , DEFER , STATE_PRD , statelv , statetime ) 
		Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 

end 



function State_PoRenDan_Add( role , sklv ) 
	local statelv = sklv  
	local atksb_dif = 50*sklv
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 



function State_PoRenDan_Rem( role , sklv ) 
	local statelv = sklv 
	local atksb_dif = 50*sklv
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 


-------��ֻȼ�յ�2
function SkillCooldown_RanShaoDan1( sklv ) 
	local Cooldown = 1500 
	return Cooldown
end

function Skill_RanShaoDan2_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2727 ) --��ֻ������1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2727 , 1 ) 
end 

function Skill_RanShaoDan2_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 2
--	 r9 = RemoveChaItem ( ATKER , 1143 , 1 , 2 , -1, 2 , 1  )
--		if r9== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
--	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 4 + sklv*2
	AddState( ATKER , DEFER , STATE_CZRSD, statelv , statetime ) 
	dmg =  math.random ( 100 , 200 )*(1+sklv*0.5)
	Hp_Endure_Dmg ( DEFER , dmg) 
end 

function State_RanShaoDan_Add ( role , statelv ) 
	local hpdmg = 150  
		Hp_Endure_Dmg ( role , hpdmg ) 
		ALLExAttrSet(role)  
end 

function State_RanShaoDan_Rem ( role , statelv ) 
end


----------------����3


function SkillCooldown_Shoulei3( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_Shoulei3_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2743 ) --����3
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2743 , 1 ) 
end 


function Skill_Shoulei3_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 3
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	dmg = 4*math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.008 * sklv) )-1200
	if dmg > 3000 then
		dmg = 3000
	end
	Hp_Endure_Dmg ( DEFER , dmg )
--	 r1 = RemoveChaItem ( ATKER , 1135 , 1 , 2 , -1, 2 , 1  )
--	 Notice("11")
--		if r1== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
end



---------------���ⵯ3

 function SkillArea_Circle_ShanGD3( sklv )									--���ܡ���Х"�ļ�������ʽ	
	local side = 800 
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_ShanGD3( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_ShanGD3_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2744 ) --���ⵯ3
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2744 , 1 ) 
end 


function Skill_ShanGD3_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	r2 = RemoveChaItem ( ATKER , 1136 , 1 , 2 , -1, 2 , 1  )
--		if r2== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
--	local hp = Hp( DEFER ) 
	local  sklv = 3
	local statelv = sklv 
	local statetime = sklv
	local hp_defer = Mxhp ( DEFER ) 
	if hp_defer >= 1000000 then 
		CALCULATE_SKILLEFFECT_LUA_000104 = GetResString("CALCULATE_SKILLEFFECT_LUA_000104")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000104 ) 
		return
	end 

		----bossʹ�ü��ܴ���
		if GetChaTypeID( ATKER ) == 979 then
			statetime = 8
		end

	if GetChaAIType( DEFER ) >= 21 then    --21����ΪBossAI�������Boss����boss��ͬ���趨���Ա���״̬�Ĵ���
		if BOSSXYSJ[GetChaTypeID( DEFER )] == 0 then
			CALCULATE_SKILLEFFECT_LUA_000028 = GetResString("CALCULATE_SKILLEFFECT_LUA_000028")
			Notice (CALCULATE_SKILLEFFECT_LUA_000028)
			return
		else
			BOSSXYSJ[GetChaTypeID( DEFER )] = BOSSXYSJ[GetChaTypeID( DEFER )] -1
		end
	end
		----bossʹ�ü��ܴ�������

	AddState( ATKER , DEFER , STATE_ShanGD, statelv , statetime ) 
--	dmg = 0.8 * math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
--	Hp_Endure_Dmg ( DEFER , dmg) 
end 
 

function State_ShanGD_Add ( role , statelv )

 end 

function State_ShanGD_Rem ( role , statelv )
 end 

 ------------------------����3

 function SkillArea_Circle_FuShe3( sklv )									--���ܡ���Х"�ļ�������ʽ	
	local  sklv = 3
	local side = 800 + sklv*100
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_FuShe3( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_FuShe3_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2745 ) --����3
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2745 , 1 ) 
end 

function Skill_FuShe3_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	 r3 = RemoveChaItem ( ATKER , 1137 , 1 , 2 , -1, 2 , 1  )
--		if r3== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local  sklv = 3
	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 15+sklv*2
	AddState( ATKER , DEFER , STATE_ZD, statelv , statetime ) 
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	local 	dmg = 2*math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.008 * sklv) )-600
	if dmg > 1500 then
		dmg = 1500
	end
	Hp_Endure_Dmg ( DEFER , dmg) 
end 
 

--function State_FuShe_Add ( role , statelv ) 
--	local hpdmg = 20
--	Hp_Endure_Dmg ( role , hpdmg ) 
--	ALLExAttrSet(role)  
--end 
--
--function State_FuShe_Rem ( role , statelv ) 
--end 

---------------------����̽����3

function SkillCooldown_YouL3( sklv )
	local Cooldown = 1500
	return Cooldown
end

function SkillArea_Square_YouL3 ( sklv )--���ܡ�ʥ��֮��"�ļ�������ʽ
	local  sklv = 3
	local side = 600 + sklv * 20 
	SetSkillRange ( 3 , side ) 	
end 

function SkillArea_State_YouL3 ( sklv )	
	local  sklv = 3
-- r3 = RemoveChaItem ( ATKER , 1138, 1 , 2 , -1, 2 , 1  )
--		if r3== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statetime = 40 + sklv *9   
	local statelv = sklv 
	SetRangeState ( STATE_SYZY , statelv  , statetime ) 									--���ӵ��桰ʥ��֮����״̬
end 

function Skill_YouL3_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		SkillUnable(role)   
		return 0
	end
	local item_count = CheckBagItem ( role , 2746 ) --����̽����2
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2746 , 1 ) 
end 

function Skill_YouL3_End ( ATKER , DEFER , sklv ) 
end 

function State_Syzy_Add ( role , statelv ) 

end 

function State_Syzy_Rem ( role , statelv ) 

end 

function State_Syzy_Tran ( statelv ) 
	return 1     
end 
----------------------------��ֻ������3
function SkillCooldown_JiaSuQi3( sklv )
	local Cooldown = 1500 
	return Cooldown
end

function Skill_JiaSuQi3_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2747 ) --��ֻ������3
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2747 , 1 ) 
end 

function Skill_JiaSuQi3_End ( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	r5 = RemoveChaItem ( ATKER , 1139 , 1 , 2 , -1, 2 , 1  )
--		if r5== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local  sklv = 3
	local statelv = sklv
	local statetime = 30+sklv*20
	AddState( ATKER , DEFER , STATE_WLJS, statelv , statetime ) 
 end

function  State_wljs_Add ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

function State_wljs_Rem  ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

----------------------------��ֻ������3
function SkillCooldown_PengSheQi3( sklv )
	local Cooldown = 1500 
	return Cooldown
end

function Skill_PengSheQi3_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2748 ) --��ֻ������3
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2748 , 1 ) 
end 

function Skill_PengSheQi3_End ( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 3
--	 r6 = RemoveChaItem ( ATKER , 1140 , 1 , 2 , -1, 2 , 1  )
--		if r6== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statetime = 3+sklv*2
	local statelv = sklv
	AddState( ATKER , DEFER , STATE_PSQ, statelv , statetime ) 
end

function  State_PengSheQi_Add ( role , statelv )
	local mspdsa_dif = 3
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

function State_PengSheQi_Rem  ( role , statelv )
	local mspdsa_dif = 3
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

--�����Ƽ�3����������������������������������������������������������������������������������������������������������������������������������������������������



function SkillCooldown_PoJiaDan3( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_PoJiaDan3_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2749 ) --���Ƽ�3
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2749 , 1 )  
end 


function Skill_PoJiaDan3_End ( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
		local  sklv = 3
--	r7= RemoveChaItem ( ATKER , 1141 , 1 , 2 , -1, 2 , 1  )
--	if r7== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
		local statelv = sklv 
		local statetime = 10 + sklv  
		dmg = math.random ( 400 , 500 )*( 1 + sklv * 0.5 )
		Hp_Endure_Dmg ( DEFER , dmg) 
		AddState ( ATKER , DEFER , STATE_PJ , statelv , statetime ) 
		--LG("skill_Pj", "function Skill_Def_Pj : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
		Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 

		--LG( "sk_pj", "�Ƽ׼��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
end 

function State_Pj_Add ( role , statelv ) 
	--LG("state", "function State_Pj_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 
	local def_dif = 30
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end 



function State_Pj_Rem ( role , statelv ) 
--	LG("state", "function State_Pj_Rem : " ,"statelv = " , statelv , " role = ", role, "\n" ) 
	local def_dif = 30
	local def = DefSb(role) + def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 

--���е�3����������������������������������������������������������������������������������������������������������������������������������������������������



function SkillCooldown_PoRenDan3( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_PoRenDan3_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2750 ) --���е�3
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2750 , 1 ) 
end 


function Skill_PoRenDan3_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
		local  sklv = 3
--	 r8 = RemoveChaItem ( ATKER , 1142 , 1 , 2 , -1, 2 , 1  )
--		if r8== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
		local statelv = sklv 
		local statetime = 10 + sklv  
		dmg = math.random ( 400 , 500 )*( 1 + sklv * 0.5 )
		Hp_Endure_Dmg ( DEFER , dmg) 
		AddState ( ATKER , DEFER , STATE_PRD , statelv , statetime ) 
		Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 

end 



function State_PoRenDan_Add( role , sklv ) 
	local statelv = sklv  
	local atksb_dif = 50*sklv
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 



function State_PoRenDan_Rem( role , sklv ) 
	local statelv = sklv 
	local atksb_dif = 50*sklv
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 


-------��ֻȼ�յ�3
function SkillCooldown_RanShaoDan3( sklv ) 
	local Cooldown = 1500 
	return Cooldown
end

function Skill_RanShaoDan3_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2751 ) --��ֻȼ�յ�3
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2751 , 1 ) 
end 

function Skill_RanShaoDan3_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 3
--	 r9 = RemoveChaItem ( ATKER , 1143 , 1 , 2 , -1, 2 , 1  )
--		if r9== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
--	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 4 + sklv*2
	AddState( ATKER , DEFER , STATE_CZRSD, statelv , statetime ) 
	dmg =  math.random ( 100 , 200 )*(1+sklv*0.5)
	Hp_Endure_Dmg ( DEFER , dmg) 
end 

function State_RanShaoDan_Add ( role , statelv ) 
	local hpdmg = 150  
		Hp_Endure_Dmg ( role , hpdmg ) 
		ALLExAttrSet(role)  
end 

function State_RanShaoDan_Rem ( role , statelv ) 
end

----------------����4


function SkillCooldown_Shoulei4( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_Shoulei4_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2767 ) --����4
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2767 , 1 ) 
end 


function Skill_Shoulei4_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 4
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	dmg = 4*math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.008 * sklv) )-1200
	if dmg > 4000 then
		dmg = 4000
	end
	Hp_Endure_Dmg ( DEFER , dmg )
--	 r1 = RemoveChaItem ( ATKER , 1135 , 1 , 2 , -1, 2 , 1  )
--	 Notice("11")
--		if r1== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
end



---------------���ⵯ4

 function SkillArea_Circle_ShanGD4( sklv )									--���ܡ���Х"�ļ�������ʽ	
	local side = 800 
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_ShanGD4( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_ShanGD4_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2768 ) --���ⵯ4
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2768 , 1 ) 
end 


function Skill_ShanGD4_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	r2 = RemoveChaItem ( ATKER , 1136 , 1 , 2 , -1, 2 , 1  )
--		if r2== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
--	local hp = Hp( DEFER ) 
	local  sklv = 4
	local statelv = sklv 
	local statetime = sklv
	local hp_defer = Mxhp ( DEFER ) 
	if hp_defer >= 1000000 then 
		CALCULATE_SKILLEFFECT_LUA_000104 = GetResString("CALCULATE_SKILLEFFECT_LUA_000104")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000104 ) 
		return
	end 

		----bossʹ�ü��ܴ���
		if GetChaTypeID( ATKER ) == 979 then
			statetime = 8
		end

	if GetChaAIType( DEFER ) >= 21 then    --21����ΪBossAI�������Boss����boss��ͬ���趨���Ա���״̬�Ĵ���
		if BOSSXYSJ[GetChaTypeID( DEFER )] == 0 then
			CALCULATE_SKILLEFFECT_LUA_000028 = GetResString("CALCULATE_SKILLEFFECT_LUA_000028")
			Notice (CALCULATE_SKILLEFFECT_LUA_000028)
			return
		else
			BOSSXYSJ[GetChaTypeID( DEFER )] = BOSSXYSJ[GetChaTypeID( DEFER )] -1
		end
	end
		----bossʹ�ü��ܴ�������

	AddState( ATKER , DEFER , STATE_ShanGD, statelv , statetime ) 
--	dmg = 0.8 * math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
--	Hp_Endure_Dmg ( DEFER , dmg) 
end 
 

function State_ShanGD_Add ( role , statelv )

 end 

function State_ShanGD_Rem ( role , statelv )
 end 

 ------------------------����4

 function SkillArea_Circle_FuShe4( sklv )									--���ܡ���Х"�ļ�������ʽ	
	local  sklv = 4
	local side = 800 + sklv*100
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_FuShe4( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_FuShe4_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2769 ) --����4
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2769 , 1 ) 
end 

function Skill_FuShe4_End( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	 r3 = RemoveChaItem ( ATKER , 1137 , 1 , 2 , -1, 2 , 1  )
--		if r3== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local  sklv = 4
	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 15+sklv*2
	AddState( ATKER , DEFER , STATE_ZD, statelv , statetime ) 
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	local 	dmg = 2*math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.008 * sklv) )-600
	if dmg > 2000 then
		dmg = 2000
	end
	Hp_Endure_Dmg ( DEFER , dmg) 
end 
 

--function State_FuShe_Add ( role , statelv ) 
--	local hpdmg = 20
--	Hp_Endure_Dmg ( role , hpdmg ) 
--	ALLExAttrSet(role)  
--end 
--
--function State_FuShe_Rem ( role , statelv ) 
--end 

---------------------����̽����4

function SkillCooldown_YouL4( sklv )
	local Cooldown = 1500
	return Cooldown
end

function SkillArea_Square_YouL4 ( sklv )--���ܡ�ʥ��֮��"�ļ�������ʽ
	local  sklv = 4
	local side = 600 + sklv * 20 
	SetSkillRange ( 3 , side ) 	
end 

function SkillArea_State_YouL4 ( sklv )	
	local  sklv = 4
-- r3 = RemoveChaItem ( ATKER , 1138, 1 , 2 , -1, 2 , 1  )
--		if r3== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statetime = 40 + sklv *9   
	local statelv = sklv 
	SetRangeState ( STATE_SYZY , statelv  , statetime ) 									--���ӵ��桰ʥ��֮����״̬
end 

function Skill_YouL4_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		SkillUnable(role)   
		return 0
	end
	local item_count = CheckBagItem ( role , 2770 ) --����̽����4
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2770 , 1 ) 
end 

function Skill_YouL4_End ( ATKER , DEFER , sklv ) 
end 

function State_Syzy_Add ( role , statelv ) 

end 

function State_Syzy_Rem ( role , statelv ) 

end 

function State_Syzy_Tran ( statelv ) 
	return 1     
end 
----------------------------��ֻ������4
function SkillCooldown_JiaSuQi4( sklv )
	local Cooldown = 1500 
	return Cooldown
end

function Skill_JiaSuQi4_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2771 ) --��ֻ������4
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2771 , 1 ) 
end 

function Skill_JiaSuQi4_End ( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	r5 = RemoveChaItem ( ATKER , 1139 , 1 , 2 , -1, 2 , 1  )
--		if r5== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local  sklv = 4
	local statelv = sklv
	local statetime = 30+sklv*20
	AddState( ATKER , DEFER , STATE_WLJS, statelv , statetime ) 
 end

function  State_wljs_Add ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

function State_wljs_Rem  ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

----------------------------��ֻ������4
function SkillCooldown_PengSheQi4( sklv )
	local Cooldown = 1500 
	return Cooldown
end

function Skill_PengSheQi4_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2772 ) --��ֻ������4
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2772 , 1 ) 
end 

function Skill_PengSheQi4_End ( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 4
--	 r6 = RemoveChaItem ( ATKER , 1140 , 1 , 2 , -1, 2 , 1  )
--		if r6== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statetime = 3+sklv*2
	local statelv = sklv
	AddState( ATKER , DEFER , STATE_PSQ, statelv , statetime ) 
end

function  State_PengSheQi_Add ( role , statelv )
	local mspdsa_dif = 3
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

function State_PengSheQi_Rem  ( role , statelv )
	local mspdsa_dif = 3
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

--�����Ƽ�4����������������������������������������������������������������������������������������������������������������������������������������������������



function SkillCooldown_PoJiaDan4( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_PoJiaDan4_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2773 ) --���Ƽ�4
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2773 , 1 )  
end 


function Skill_PoJiaDan4_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
		local  sklv = 4
--	r7= RemoveChaItem ( ATKER , 1141 , 1 , 2 , -1, 2 , 1  )
--	if r7== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statelv = sklv 
	local statetime = 10 + sklv  
	dmg = math.random ( 400 , 500 )*( 1 + sklv * 0.5 )
	Hp_Endure_Dmg ( DEFER , dmg) 
	AddState ( ATKER , DEFER , STATE_PJ , statelv , statetime ) 
	--LG("skill_Pj", "function Skill_Def_Pj : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 

	--LG( "sk_pj", "�Ƽ׼��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
end 

function State_Pj_Add ( role , statelv ) 
	--LG("state", "function State_Pj_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 
	local def_dif = 30
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end 



function State_Pj_Rem ( role , statelv ) 
--	LG("state", "function State_Pj_Rem : " ,"statelv = " , statelv , " role = ", role, "\n" ) 
	local def_dif = 30
	local def = DefSb(role) + def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 

--���е�4����������������������������������������������������������������������������������������������������������������������������������������������������



function SkillCooldown_PoRenDan4( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_PoRenDan4_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2774 ) --���е�4
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2774 , 1 ) 
end 


function Skill_PoRenDan4_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
		local  sklv = 4
--	 r8 = RemoveChaItem ( ATKER , 1142 , 1 , 2 , -1, 2 , 1  )
--		if r8== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statelv = sklv 
	local statetime = 10 + sklv  
	dmg = math.random ( 400 , 500 )*( 1 + sklv * 0.5 )
	Hp_Endure_Dmg ( DEFER , dmg) 
	AddState ( ATKER , DEFER , STATE_PRD , statelv , statetime ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 

end 



function State_PoRenDan_Add( role , sklv ) 
	local statelv = sklv  
	local atksb_dif = 50*sklv
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 



function State_PoRenDan_Rem( role , sklv ) 
	local statelv = sklv 
	local atksb_dif = 50*sklv
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 


-------��ֻȼ�յ�4
function SkillCooldown_RanShaoDan4( sklv ) 
	local Cooldown = 1500 
	return Cooldown
end

function Skill_RanShaoDan4_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2775 ) --��ֻȼ�յ�4
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2775 , 1 ) 
end 

function Skill_RanShaoDan4_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 4
--	 r9 = RemoveChaItem ( ATKER , 1143 , 1 , 2 , -1, 2 , 1  )
--		if r9== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
--	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 4 + sklv*2
	AddState( ATKER , DEFER , STATE_CZRSD, statelv , statetime ) 
	dmg =  math.random ( 100 , 200 )*(1+sklv*0.5)
	Hp_Endure_Dmg ( DEFER , dmg) 
end 

function State_RanShaoDan_Add ( role , statelv ) 
	local hpdmg = 150  
		Hp_Endure_Dmg ( role , hpdmg ) 
		ALLExAttrSet(role)  
end 

function State_RanShaoDan_Rem ( role , statelv ) 
end


----------------����5


function SkillCooldown_Shoulei5( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_Shoulei5_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2791 ) --����5
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2791 , 1 ) 
end 


function Skill_Shoulei5_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 5
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	dmg = 4*math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.008 * sklv) )-1200
	if dmg > 5000 then
		dmg = 5000
	end
	Hp_Endure_Dmg ( DEFER , dmg )
--	 r1 = RemoveChaItem ( ATKER , 1135 , 1 , 2 , -1, 2 , 1  )
--	 Notice("11")
--		if r1== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
end



---------------���ⵯ5

 function SkillArea_Circle_ShanGD5( sklv )									--���ܡ���Х"�ļ�������ʽ	
	local side = 800 
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_ShanGD5( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_ShanGD5_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2792 ) --���ⵯ5
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2792 , 1 ) 
end 


function Skill_ShanGD5_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	r2 = RemoveChaItem ( ATKER , 1136 , 1 , 2 , -1, 2 , 1  )
--		if r2== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
--	local hp = Hp( DEFER ) 
	local  sklv = 5
	local statelv = sklv 
	local statetime = sklv
	local hp_defer = Mxhp ( DEFER ) 
	if hp_defer >= 1000000 then 
		CALCULATE_SKILLEFFECT_LUA_000104 = GetResString("CALCULATE_SKILLEFFECT_LUA_000104")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000104 ) 
		return
	end 
	AddState( ATKER , DEFER , STATE_ShanGD, statelv , statetime ) 
--	dmg = 0.8 * math.random ( Mnatk( ATKER ) , Mxatk ( ATKER ) ) 
--	Hp_Endure_Dmg ( DEFER , dmg) 
end 
 

function State_ShanGD_Add ( role , statelv )

 end 

function State_ShanGD_Rem ( role , statelv )
 end 

 ------------------------����5

 function SkillArea_Circle_FuShe5( sklv )									--���ܡ���Х"�ļ�������ʽ	
	local  sklv = 5
	local side = 800 + sklv*100
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_FuShe5( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_FuShe5_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2793 ) --����5
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2793 , 1 ) 
end 

function Skill_FuShe5_End( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	 r3 = RemoveChaItem ( ATKER , 1137 , 1 , 2 , -1, 2 , 1  )
--		if r3== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local  sklv = 5
	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 15+sklv*2
	AddState( ATKER , DEFER , STATE_ZD, statelv , statetime ) 
	local 	hp = GetChaAttr ( DEFER , ATTR_HP ) 
	local 	dmg = 2*math.floor ( 320 + 30 * sklv +hp * ( 0.05 +0.008 * sklv) )-600
	if dmg > 2500 then
		dmg = 2500
	end
	Hp_Endure_Dmg ( DEFER , dmg) 
end 
 

---------------------����̽����5

function SkillCooldown_YouL5( sklv )
	local Cooldown = 1500
	return Cooldown
end

function SkillArea_Square_YouL5 ( sklv )--���ܡ�ʥ��֮��"�ļ�������ʽ
	local  sklv = 5
	local side = 600 + sklv * 20 
	SetSkillRange ( 3 , side ) 	
end 

function SkillArea_State_YouL5 ( sklv )	
	local  sklv = 5
-- r3 = RemoveChaItem ( ATKER , 1138, 1 , 2 , -1, 2 , 1  )
--		if r3== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statetime = 40 + sklv *9   
	local statelv = sklv 
	SetRangeState ( STATE_SYZY , statelv  , statetime ) 									--���ӵ��桰ʥ��֮����״̬
end 

function Skill_YouL5_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		SkillUnable(role)   
		return 0
	end
	local item_count = CheckBagItem ( role , 2794 ) --����̽����5
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2794 , 1 ) 
end 

function Skill_YouL5_End ( ATKER , DEFER , sklv ) 
end 

function State_Syzy_Add ( role , statelv ) 

end 

function State_Syzy_Rem ( role , statelv ) 

end 

function State_Syzy_Tran ( statelv ) 
	return 1     
end 
----------------------------��ֻ������5
function SkillCooldown_JiaSuQi5( sklv )
	local Cooldown = 1500 
	return Cooldown
end

function Skill_JiaSuQi5_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2795 ) --��ֻ������5
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2795 , 1 ) 
end 

function Skill_JiaSuQi5_End ( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
--	r5 = RemoveChaItem ( ATKER , 1139 , 1 , 2 , -1, 2 , 1  )
--		if r5== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local  sklv = 5
	local statelv = sklv
	local statetime = 30+sklv*20
	AddState( ATKER , DEFER , STATE_WLJS, statelv , statetime ) 
 end

function  State_wljs_Add ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

function State_wljs_Rem  ( role , statelv )
	local mspdsa_dif = 1
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

----------------------------��ֻ������5
function SkillCooldown_PengSheQi5( sklv )
	local Cooldown = 1500 
	return Cooldown
end

function Skill_PengSheQi5_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2796 ) --��ֻ������5
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2796 , 1 ) 
end 

function Skill_PengSheQi5_End ( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 5
--	 r6 = RemoveChaItem ( ATKER , 1140 , 1 , 2 , -1, 2 , 1  )
--		if r6== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statetime = 3+sklv*2
	local statelv = sklv
	AddState( ATKER , DEFER , STATE_PSQ, statelv , statetime ) 
end

function  State_PengSheQi_Add ( role , statelv )
	local mspdsa_dif = 3
	local mspdsa = (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

function State_PengSheQi_Rem  ( role , statelv )
	local mspdsa_dif = 3
	local mspdsa = (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD )  
	 
	ALLExAttrSet(role)  
end 

--�����Ƽ�5����������������������������������������������������������������������������������������������������������������������������������������������������



function SkillCooldown_PoJiaDan5( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_PoJiaDan5_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2797 ) --���Ƽ�5
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2797 , 1 )  
end 


function Skill_PoJiaDan5_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 5
--	r7= RemoveChaItem ( ATKER , 1141 , 1 , 2 , -1, 2 , 1  )
--	if r7== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statelv = sklv 
	local statetime = 10 + sklv  
	dmg = math.random ( 400 , 500 )*( 1 + sklv * 0.5 )
	Hp_Endure_Dmg ( DEFER , dmg) 
	AddState ( ATKER , DEFER , STATE_PJ , statelv , statetime ) 
	--LG("skill_Pj", "function Skill_Def_Pj : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 

	--LG( "sk_pj", "�Ƽ׼��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
end 

function State_Pj_Add ( role , statelv ) 
	--LG("state", "function State_Pj_Add : " , " role = ", role, "statelv = " , statelv , "\n" ) 
	local def_dif = 30
	local def = DefSb(role) - def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )	
	ALLExAttrSet(role)

end 



function State_Pj_Rem ( role , statelv ) 
--	LG("state", "function State_Pj_Rem : " ,"statelv = " , statelv , " role = ", role, "\n" ) 
	local def_dif = 30
	local def = DefSb(role) + def_dif
	SetCharaAttr( def , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end 

--���е�5����������������������������������������������������������������������������������������������������������������������������������������������������



function SkillCooldown_PoRenDan5( sklv )
	local Cooldown = 1500
	return Cooldown
end

function Skill_PoRenDan5_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2798 ) --���е�5
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2798 , 1 ) 
end 


function Skill_PoRenDan5_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 5
--	 r8 = RemoveChaItem ( ATKER , 1142 , 1 , 2 , -1, 2 , 1  )
--		if r8== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
	local statelv = sklv 
	local statetime = 10 + sklv  
	dmg = math.random ( 400 , 500 )*( 1 + sklv * 0.5 )
	Hp_Endure_Dmg ( DEFER , dmg) 
	AddState ( ATKER , DEFER , STATE_PRD , statelv , statetime ) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 

end 



function State_PoRenDan_Add( role , sklv ) 
	local statelv = sklv  
	local atksb_dif = 50*sklv
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 



function State_PoRenDan_Rem( role , sklv ) 
	local statelv = sklv 
	local atksb_dif = 50*sklv
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)  
end 


-------��ֻȼ�յ�5
function SkillCooldown_RanShaoDan5( sklv ) 
	local Cooldown = 1500 
	return Cooldown
end

function Skill_RanShaoDan5_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 2799 ) --��ֻȼ�յ�5
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2799 , 1 ) 
end 

function Skill_RanShaoDan5_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local  sklv = 5
--	 r9 = RemoveChaItem ( ATKER , 1143 , 1 , 2 , -1, 2 , 1  )
--		if r9== 0 then
--		LG( "�Ƴ���Ʒʧ��" )
--		return
--	end
--	local hp = Hp( DEFER ) 
	local statelv = sklv 
	local statetime = 4 + sklv*2
	AddState( ATKER , DEFER , STATE_CZRSD, statelv , statetime ) 
	dmg =  math.random ( 100 , 200 )*(1+sklv*0.5)
	Hp_Endure_Dmg ( DEFER , dmg) 
end 

function State_RanShaoDan_Add ( role , statelv ) 
	local hpdmg = 150  
		Hp_Endure_Dmg ( role , hpdmg ) 
		ALLExAttrSet(role)  
end 

function State_RanShaoDan_Rem ( role , statelv ) 
end
----------------------------------------------Сѩ�� 
function SkillCooldown_Xiaoxueqiu ( sklv )
	local Cooldown = 3000
	return Cooldown
end
function Skill_Xiaoxueqiu_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 2896 ) 
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2896 , 1 ) 

end 
function Skill_Xiaoxueqiu_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local statetime = 2 
	local statelv = 10 
	local rad_star = math.random ( 1, 3 )
	if rad_star==1 then
		AddState ( ATKER , DEFER , STATE_GANMAO , statelv , statetime )
	end
end

--��ʴ֮��LV1����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_FuShiZhiQiu1( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_FuShiZhiQiu1_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(atk_role)
			return 0
		end
	local item_count = CheckBagItem ( atk_role , 1146 ) --��ʴ֮��LV1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 1146 , 1 ) 
end 

function Skill_FuShiZhiQiu1_End ( ATKER , DEFER , sklv ) 
		local sklv = 1 
		local statelv=sklv
		local statetime = 5 + 4 *  sklv
		AddState ( ATKER , DEFER , STATE_FSZQ , statelv , statetime )  
end 


function State_FuShiZhiQiu_Add ( role , statelv ) 
	
	local bd=GetChaAttr(role, ATTR_BPDEF)
	local defsa_dif = (-1) * ( 0.03 * statelv ) 
	local defsa = math.floor (  (DefSa(role) + defsa_dif ) * ATTR_RADIX ) 
	local bd_dif = (-1) * ( 0.02 * statelv )
	local bd_fin = math.floor (  (ResistSa(role) + bd_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	SetCharaAttr( bd_fin , role , ATTR_STATEC_PDEF ) 
	ALLExAttrSet(role)  
end 

function State_FuShiZhiQiu_Rem ( role , statelv )  
	
	local bd=GetChaAttr(role, ATTR_BPDEF)
	local defsa_dif = (-1) * ( 0.03 * statelv ) 
	local defsa = math.floor (  (DefSa(role) - defsa_dif ) * ATTR_RADIX ) 
	local bd_dif = (-1) * ( 0.02 * statelv )
	local bd_fin = math.floor (  (ResistSa(role) - bd_dif ) * ATTR_RADIX ) 
	SetCharaAttr( defsa , role , ATTR_STATEC_DEF ) 
	SetCharaAttr( bd_fin , role , ATTR_STATEC_PDEF ) 
	ALLExAttrSet(role)  
end 
--��ʴ֮��LV2����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_FuShiZhiQiu2( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_FuShiZhiQiu2_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(atk_role)
			return 0
		end
	local item_count = CheckBagItem ( atk_role , 2730 ) --��ʴ֮��LV2
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2730 , 1 ) 
end 

function Skill_FuShiZhiQiu2_End ( ATKER , DEFER , sklv ) 
		local sklv = 2 
		local statelv=sklv
		local statetime = 5 + 4 *  sklv
		AddState ( ATKER , DEFER , STATE_FSZQ , statelv , statetime )  
end 





--��ʴ֮��LV3����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_FuShiZhiQiu3( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_FuShiZhiQiu3_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(atk_role)
			return 0
		end
	local item_count = CheckBagItem ( atk_role , 2754 ) --��ʴ֮��LV3
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2754 , 1 ) 
end 

function Skill_FuShiZhiQiu3_End ( ATKER , DEFER , sklv ) 
		local sklv = 3
		local statelv=sklv
		local statetime = 5 + 4 *  sklv
		AddState ( ATKER , DEFER , STATE_FSZQ , statelv , statetime )  
end 


--��ʴ֮��LV4����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_FuShiZhiQiu4( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_FuShiZhiQiu4_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(atk_role)
			return 0
		end
	local item_count = CheckBagItem ( atk_role , 2778 ) --��ʴ֮��LV4
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2778 , 1 ) 
end 

function Skill_FuShiZhiQiu4_End ( ATKER , DEFER , sklv ) 
		local sklv =  4
		local statelv=sklv
		local statetime = 5 + 4 *  sklv
		AddState ( ATKER , DEFER , STATE_FSZQ , statelv , statetime )  
end 




--��ʴ֮��LV5����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_FuShiZhiQiu5( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_FuShiZhiQiu5_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(atk_role)
			return 0
		end
	local item_count = CheckBagItem ( atk_role , 2802 ) --��ʴ֮��LV5
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2802 , 1 ) 
end 

function Skill_FuShiZhiQiu5_End ( ATKER , DEFER , sklv ) 
		local sklv =  5
		local statelv=sklv
		local statetime = 5 + 4 *  statelv
		AddState ( ATKER , DEFER , STATE_FSZQ , statelv , statetime )  
end 



--����������LV1����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_ZaoYinZhiZao1( sklv )
	local Cooldown = 1500
	return Cooldown
end

function SkillArea_Square_ZaoYinZhiZao1( sklv )
        local sklv = 1
	local side = 550 + sklv * 40
        SetSkillRange ( 4 , side  )  
end 

function SkillArea_State_ZaoYinZhiZao1 ( sklv )
        local sklv = 1
	local statetime = 15 + sklv * 2 
	local statelv = sklv 
	SetRangeState ( STATE_ZYZZ , statelv  , statetime )									
end 

function Skill_ZaoYinZhiZao1_Begin ( role , sklv ) 

local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local item_count = CheckBagItem ( role , 1147 ) --����������Lv1
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 1147 , 1 ) 
end 


function Skill_ZaoYinZhiZao1_End ( ATKER , DEFER , sklv )
end
 
function State_ZaoYinZhiZao_Add ( role , statelv )

        
	local sp_sum = -15*statelv
        local sp = GetChaAttr(role, ATTR_SP) 
	sp=sp+sp_sum
	if sp < 0 
	then    
	   sp = 0                       
        end 
	SetCharaAttr ( sp , role , ATTR_SP ) 
	ALLExAttrSet(role)
        
--       local sta_dif = (-1) * ( 0.05 + 0.1 * statelv )
--       local sta = math.floor(  (StaSa(role) + sta_dif) * ATTR_RADIX ) ----------------��15%�������
--       SetCharaAttr( sta , role , ATTR_STATEC_STA )	
--       ALLExAttrSet(role)

end 

function State_ZaoYinZhiZao_Rem ( role , statelv )

       
--       local sta_dif = (-1) * ( 0.05 + 0.1 * statelv )
--       local sta = math.floor(  (StaSa(role) - sta_dif) * ATTR_RADIX ) 
--       SetCharaAttr( sta , role , ATTR_STATEC_STA )	
--       ALLExAttrSet(role)

end  

function State_ZaoYinZhiZao_Tran ( statelv ) 
         return 1
end
--����������LV2����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_ZaoYinZhiZao2( sklv )
	local Cooldown = 1500
	return Cooldown
end

function SkillArea_Square_ZaoYinZhiZao2( sklv )
        local sklv = 2
	local side = 550 + sklv * 40
        SetSkillRange ( 4 , side  )  
end 

function SkillArea_State_ZaoYinZhiZao2 ( sklv )
        local sklv = 2
	local statetime = 15 + sklv * 2 
	local statelv = sklv 
	SetRangeState ( STATE_ZYZZ , statelv  , statetime )									
end 

function Skill_ZaoYinZhiZao2_Begin ( role , sklv ) 

local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local item_count = CheckBagItem ( role , 2731 ) --����������Lv2
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2731 , 1 ) 
end 


function Skill_ZaoYinZhiZao2_End ( ATKER , DEFER , sklv )
end
 


--����������LV3����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_ZaoYinZhiZao3( sklv )
	local Cooldown = 1500
	return Cooldown
end

function SkillArea_Square_ZaoYinZhiZao3( sklv )
        local sklv = 1
	local side = 550 + sklv * 40
        SetSkillRange ( 4 , side  )  
end 

function SkillArea_State_ZaoYinZhiZao3 ( sklv )
        local sklv = 3
	local statetime = 15 + sklv * 2 
	local statelv = sklv 
	SetRangeState ( STATE_ZYZZ , statelv  , statetime )									
end 

function Skill_ZaoYinZhiZao3_Begin ( role , sklv ) 

local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local item_count = CheckBagItem ( role , 2755 ) --����������Lv3
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2755 , 1 ) 
end 


function Skill_ZaoYinZhiZao3_End ( ATKER , DEFER , sklv )
end
 


--����������LV4����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_ZaoYinZhiZao4( sklv )
	local Cooldown = 1500
	return Cooldown
end

function SkillArea_Square_ZaoYinZhiZao4( sklv )
        local sklv = 1
	local side = 550 + sklv * 40
        SetSkillRange ( 4 , side  )  
end 

function SkillArea_State_ZaoYinZhiZao4 ( sklv )
        local sklv = 4
	local statetime = 15 + sklv * 2 
	local statelv = sklv 
	SetRangeState ( STATE_ZYZZ , statelv  , statetime )									
end 

function Skill_ZaoYinZhiZao4_Begin ( role , sklv ) 

local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local item_count = CheckBagItem ( role , 2779 ) --����������Lv4
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2779 , 1 ) 
end 


function Skill_ZaoYinZhiZao4_End ( ATKER , DEFER , sklv )
end
 


--����������LV5����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_ZaoYinZhiZao5( sklv )
	local Cooldown = 1500
	return Cooldown
end

function SkillArea_Square_ZaoYinZhiZao5( sklv )
        local sklv = 5
	local side = 550 + sklv * 40
        SetSkillRange ( 4 , side  )  
end 

function SkillArea_State_ZaoYinZhiZao5 ( sklv )
        local sklv = 5
	local statetime = 15 + sklv * 2 
	local statelv = sklv 
	SetRangeState ( STATE_ZYZZ , statelv  , statetime )									
end 

function Skill_ZaoYinZhiZao5_Begin ( role , sklv ) 

local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local item_count = CheckBagItem ( role , 2803 ) --����������Lv5
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2803 , 1 ) 
end 


function Skill_ZaoYinZhiZao5_End ( ATKER , DEFER , sklv )
end
 




--��������LV1����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_DiZhenFaSheng1( sklv )
	local Cooldown = 3000
	return Cooldown
end

function SkillArea_Circle_DiZhenFaSheng1 ( sklv )
        local sklv = 1
	local side = 550 + sklv * 40 
	SetSkillRange ( 4 , side ) 	
end 

function SkillArea_State_DiZhenFaSheng1 ( sklv )
        local sklv = 1
	local statetime = 10 + sklv * 2     
	local statelv = sklv  
	SetRangeState ( STATE_DZFS , statelv  , statetime ) 									
end 

function Skill_DiZhenFaSheng1_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		    then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local item_count = CheckBagItem ( role , 1148 ) --��������Lv1
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 1148 , 1 ) 
end 
	
 

function Skill_DiZhenFaSheng1_End ( ATKER , DEFER , sklv ) 
end 

function State_DiZhenFaSheng_Add ( role , statelv ) 
      
	
	local mspdsa_dif = (-1) * ( 0.2 * statelv + 0.1 ) 
	local mspdsa = math.floor (  (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX ) 
        SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 

function State_DiZhenFaSheng_Rem ( role , statelv ) 

        
        local mspdsa_dif = (-1) * ( 0.2 * statelv + 0.1 )  
	local mspdsa = math.floor (  (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX ) 
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 

function State_DiZhenFaSheng_Tran ( statelv ) 
         return 1
end 
--��������LV2����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_DiZhenFaSheng2( sklv )
	local Cooldown = 3000
	return Cooldown
end

function SkillArea_Circle_DiZhenFaSheng2 ( sklv )
        local sklv = 2
	local side = 550 + sklv * 40 
	SetSkillRange ( 4 , side ) 	
end 

function SkillArea_State_DiZhenFaSheng2 ( sklv )
        local sklv = 2
	local statetime = 10 + sklv * 2     
	local statelv = sklv  
	SetRangeState ( STATE_DZFS , statelv  , statetime ) 									
end 

function Skill_DiZhenFaSheng2_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		    then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local item_count = CheckBagItem ( role , 2732 ) --��������Lv2
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2732 , 1 ) 
end 
	
 

function Skill_DiZhenFaSheng2_End ( ATKER , DEFER , sklv ) 
end 



--��������LV3����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_DiZhenFaSheng3( sklv )
	local Cooldown = 3000
	return Cooldown
end

function SkillArea_Circle_DiZhenFaSheng3 ( sklv )
        local sklv = 3
	local side = 550 + sklv * 40 
	SetSkillRange ( 4 , side ) 	
end 

function SkillArea_State_DiZhenFaSheng3 ( sklv )
        local sklv = 3
	local statetime = 10 + sklv * 2     
	local statelv = sklv  
	SetRangeState ( STATE_DZFS , statelv  , statetime ) 									
end 

function Skill_DiZhenFaSheng3_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		    then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local item_count = CheckBagItem ( role , 2756 ) --��������Lv3
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2756 , 1 ) 
end 
	
 

function Skill_DiZhenFaSheng3_End ( ATKER , DEFER , sklv ) 
end 



--��������LV4����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_DiZhenFaSheng4( sklv )
	local Cooldown = 3000
	return Cooldown
end

function SkillArea_Circle_DiZhenFaSheng4 ( sklv )
        local sklv = 4
	local side = 550 + sklv * 40 
	SetSkillRange ( 4 , side ) 	
end 

function SkillArea_State_DiZhenFaSheng4 ( sklv )
        local sklv = 4
	local statetime = 10 + sklv * 2     
	local statelv = sklv  
	SetRangeState ( STATE_DZFS , statelv  , statetime ) 									
end 

function Skill_DiZhenFaSheng4_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		    then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local item_count = CheckBagItem ( role , 2780 ) --��������Lv4
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2780 , 1 ) 
end 
	
 

function Skill_DiZhenFaSheng4_End ( ATKER , DEFER , sklv ) 
end 



--��������LV5����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_DiZhenFaSheng5( sklv )
	local Cooldown = 3000
	return Cooldown
end

function SkillArea_Circle_DiZhenFaSheng5 ( sklv )
        local sklv = 5
	local side = 550 + sklv * 40 
	SetSkillRange ( 4 , side ) 	
end 

function SkillArea_State_DiZhenFaSheng5 ( sklv )
        local sklv = 5
	local statetime = 10 + sklv * 2     
	local statelv = sklv  
	SetRangeState ( STATE_DZFS , statelv  , statetime ) 									
end 

function Skill_DiZhenFaSheng5_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		    then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local item_count = CheckBagItem ( role , 2804 ) --��������Lv5
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 2804 , 1 ) 
end 
	
 

function Skill_DiZhenFaSheng5_End ( ATKER , DEFER , sklv ) 
end 




--����LV1����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_LianDan1( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_LianDan1_Begin ( role , sklv ) 

local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2677 ) --����1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2677 , 1 )  
end 

function Skill_LianDan1_End ( ATKER , DEFER , sklv ) 

		local  sklv = 1
	        local statelv = sklv
	        local statetime = 30+sklv*20  
		AddState ( ATKER , DEFER , STATE_LD , statelv , statetime ) 
end 

function State_LianDan_Add( role , statelv ) 
        
    
	local mspdsa_dif =  0.3 + 0.09 * statelv 
	--local mspdsa_dif = 1 
	local mspdsa = math.floor (  (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX ) 
	
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 

function State_LianDan_Rem( role , statelv ) 
       
	local mspdsa_dif =  0.3 + 0.09 * statelv 
	--local mspdsa_dif = 1
	local mspdsa = math.floor (  (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX ) 
        SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end

--����LV2����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_LianDan2( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_LianDan2_Begin ( role , sklv ) 
local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2741 ) --����2
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2741 , 1 )  
end 

function Skill_LianDan2_End ( ATKER , DEFER , sklv ) 
		local  sklv = 2
	        local statelv = sklv
	        local statetime = 30+sklv*20   
		AddState ( ATKER , DEFER , STATE_LD , statelv , statetime ) 
end 


--����LV3����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_LianDan3( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_LianDan3_Begin ( role , sklv ) 
local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2765 ) --����3
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2765 , 1 )  
end 

function Skill_LianDan3_End ( ATKER , DEFER , sklv ) 
		local  sklv = 3
	        local statelv = sklv
	        local statetime = 30+sklv*20  
		AddState ( ATKER , DEFER , STATE_LD , statelv , statetime ) 
end 



--����LV4����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_LianDan4( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_LianDan4_Begin ( role , sklv ) 
local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2789 ) --����4
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2789 , 1 )  
end 

function Skill_LianDan4_End ( ATKER , DEFER , sklv ) 
		local  sklv = 4
	        local statelv = sklv
	        local statetime = 30+sklv*20  
		AddState ( ATKER , DEFER , STATE_LD , statelv , statetime ) 
end 



--����LV5����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_LianDan5( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_LianDan5_Begin ( role , sklv ) 
local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2813 ) --����5
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2813 , 1 )  
end 

function Skill_LianDan5_End ( ATKER , DEFER , sklv ) 
		local  sklv = 5
	        local statelv = sklv
	        local statetime = 30+sklv*20   
		AddState ( ATKER , DEFER , STATE_LD , statelv , statetime ) 
end 



--��Ӱ������LV1����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_HuanYinFaSheng1( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_HuanYinFaSheng1_Begin ( role , sklv ) 
local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2673 ) --��Ӱ������1
	if item_count <= 0 
	then  
		SkillUnable(atk_role) 
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 )
		return 0
		
	end 
	local a = DelBagItem ( atk_role , 2673 , 1 )  
end 

function Skill_HuanYinFaSheng1_End ( ATKER , DEFER , sklv ) 
		local sklv = 1 
		local statelv = sklv
		local statetime =  2 + sklv*3    
		AddState ( ATKER , DEFER , STATE_HYFS , statelv , statetime )  
end 
function State_HuanYinFaSheng_Add( role , statelv ) 
	 
end 
function State_HuanYinFaSheng_Add( role , statelv ) 
end 
--��Ӱ������LV2����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_HuanYinFaSheng2( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_HuanYinFaSheng2_Begin ( role , sklv ) 
local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2737 ) --��Ӱ������2
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 )
		return 0
	end 
	local a = DelBagItem ( atk_role , 2737 , 1 )  
end 

function Skill_HuanYinFaSheng2_End ( ATKER , DEFER , sklv ) 
		local sklv = 2 
		local statelv = sklv
		local statetime =  2 + sklv*3    
		AddState ( ATKER , DEFER , STATE_HYFS , statelv , statetime )  
end 

--��Ӱ������LV3����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_HuanYinFaSheng3( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_HuanYinFaSheng3_Begin ( role , sklv ) 
local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2761 ) --��Ӱ������1
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return 0
	end 
	local a = DelBagItem ( atk_role , 2761 , 1 )  
end 

function Skill_HuanYinFaSheng3_End ( ATKER , DEFER , sklv ) 
		local sklv = 3 
		local statelv = sklv
		local statetime =  2 + sklv*3    
		AddState ( ATKER , DEFER , STATE_HYFS , statelv , statetime )  
end 

--��Ӱ������LV4����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_HuanYinFaSheng4( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_HuanYinFaSheng4_Begin ( role , sklv ) 
local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2785 ) --��Ӱ������1
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return 0
	end 
	local a = DelBagItem ( atk_role , 2785 , 1 )  
end 

function Skill_HuanYinFaSheng4_End ( ATKER , DEFER , sklv ) 
		local sklv = 4 
		local statelv = sklv
		local statetime =  2 + sklv*3    
		AddState ( ATKER , DEFER , STATE_HYFS , statelv , statetime )  
end 

--��Ӱ������LV5����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_HuanYinFaSheng5( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_HuanYinFaSheng5_Begin ( role , sklv ) 
local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2809 ) --��Ӱ������1
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return 0
	end 
	local a = DelBagItem ( atk_role , 2809 , 1 )  
end 

function Skill_HuanYinFaSheng5_End ( ATKER , DEFER , sklv ) 
		local sklv = 5 
		local statelv = sklv
		local statetime =  2 + sklv*3    
		AddState ( ATKER , DEFER , STATE_HYFS , statelv , statetime )  
end 



--��ֻǱ��LV1����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_ChuanZhiQianXing1( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 
function Skill_ChuanZhiQianXing1_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0

		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2675 ) --Ǳ��1
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2675 , 1 )  
	 
end
function Skill_ChuanZhiQianXing1_End ( ATKER , DEFER , sklv )
        local sklv = 1
	local statelv = sklv 
	local statetime = 5 + sklv * 15  
	AddState ( ATKER , DEFER , STATE_CZQX , statelv , statetime )  
end

function State_ChuanZhiQianXing_Add ( role , statelv ) 
	
end
function State_ChuanZhiQianXing_Rem  ( role , statelv ) 
end
--��ֻǱ��LV2����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_ChuanZhiQianXing2( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 
function Skill_ChuanZhiQianXing2_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2739 ) --Ǳ��2
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2739 , 1 )  
	 
end
function Skill_ChuanZhiQianXing2_End ( ATKER , DEFER , sklv ) 
        local sklv = 2
	local statelv = sklv 
	local statetime = 5 + sklv * 15  
	AddState ( ATKER , DEFER , STATE_CZQX , statelv , statetime )  
end



--��ֻǱ��LV3����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_ChuanZhiQianXing3( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 
function Skill_ChuanZhiQianXing3_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2763 ) --Ǳ��3
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2763 , 1 )  
	 
end
function Skill_ChuanZhiQianXing3_End ( ATKER , DEFER , sklv ) 
        local sklv = 3
	local statelv = sklv 
	local statetime = 5 + sklv * 15  
	AddState ( ATKER , DEFER , STATE_CZQX , statelv , statetime )  
end



--��ֻǱ��LV4����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_ChuanZhiQianXing4( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 
function Skill_ChuanZhiQianXing4_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2787 ) --Ǳ��4
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2787 , 1 )  
	 
end
function Skill_ChuanZhiQianXing4_End ( ATKER , DEFER , sklv ) 
        local sklv = 4
	local statelv = sklv 
	local statetime = 5 + sklv * 15  
	AddState ( ATKER , DEFER , STATE_CZQX , statelv , statetime )  
end



--��ֻǱ��LV5����������������������������������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_ChuanZhiQianXing5( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 
function Skill_ChuanZhiQianXing5_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2811 ) --Ǳ��5
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 2811 , 1 )  
	 
end
function Skill_ChuanZhiQianXing5_End ( ATKER , DEFER , sklv ) 
        local sklv = 5
	local statelv = sklv 
	local statetime = 5 + sklv * 15  
	AddState ( ATKER , DEFER , STATE_CZQX , statelv , statetime )  
end




--�״�LV1��������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_LeiDa1( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 
function SkillArea_Square_LeiDa1( sklv )
      
        local sklv = 1
	local side = 50 + sklv * 300
	SetSkillRange ( 3 , side ) 	
end 
function SkillArea_State_LeiDa1 ( sklv )
     
        local sklv = 1
	local statetime = 15 + sklv *55   
	local statelv = sklv 
	SetRangeState ( STATE_LEIDA , statelv  , statetime ) 						
end 
function Skill_LeiDa1_Begin ( role , sklv ) 
   
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		then
			SkillUnable(role)
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2676 ) --�״�1
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		
	end 
	local a = DelBagItem ( atk_role , 2676 , 1 )  
	 
end
function Skill_LeiDa1_End ( ATKER , DEFER , sklv ) 
end 
function State_LeiDa_Add ( role , statelv ) 
end 
function State_LeiDa_Rem ( role , statelv ) 
end 
function State_LeiDa_Tran ( statelv ) 
	return 1     
end
--�״�LV2��������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_LeiDa2( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 
function SkillArea_Square_LeiDa2( sklv )
        local sklv = 2
	local side = 50 + sklv * 300 
	SetSkillRange ( 3 , side ) 	
end 
function SkillArea_State_LeiDa2 ( sklv )
        local sklv = 2
	local statetime = 15 + sklv *55   
	local statelv = sklv 
	SetRangeState ( STATE_LEIDA , statelv  , statetime ) 						
end 
function Skill_LeiDa2_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		then
			SkillUnable(role)
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2740 ) --�״�2
	if item_count <= 0 
	then  
		SkillUnable(atk_role)  
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		
	end 
	local a = DelBagItem ( atk_role , 2740 , 1 )  
	 
end
function Skill_LeiDa2_End ( ATKER , DEFER , sklv ) 
end 

--�״�LV3��������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_LeiDa3( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 
function SkillArea_Square_LeiDa3( sklv )
        local sklv = 3
	local side = 50 + sklv * 300 
	SetSkillRange ( 3 , side ) 	
end 
function SkillArea_State_LeiDa3 ( sklv )
        local sklv = 3
	local statetime = 15 + sklv *55   
	local statelv = sklv 
	SetRangeState ( STATE_LEIDA , statelv  , statetime ) 						
end 
function Skill_LeiDa3_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		then
			SkillUnable(role)
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2764 ) --�״�3
	if item_count <= 0 
	then  
		SkillUnable(atk_role)  
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		
	end 
	local a = DelBagItem ( atk_role , 2764 , 1 )  
	 
end
function Skill_LeiDa3_End ( ATKER , DEFER , sklv ) 
end 

--�״�LV4��������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_LeiDa4( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 
function SkillArea_Square_LeiDa4( sklv )
        local sklv = 4
	local side = 50 + sklv * 300 
	SetSkillRange ( 3 , side ) 	
end 
function SkillArea_State_LeiDa4 ( sklv )
        local sklv = 4
	local statetime = 15 + sklv *55   
	local statelv = sklv 
	SetRangeState ( STATE_LEIDA , statelv  , statetime ) 						
end 
function Skill_LeiDa4_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		then
			SkillUnable(role)
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2788 ) --�״�4
	if item_count <= 0 
	then  
		SkillUnable(atk_role)  
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		
	end 
	local a = DelBagItem ( atk_role , 2788 , 1 )  
	 
end
function Skill_LeiDa4_End ( ATKER , DEFER , sklv ) 
end 

--�״�LV5��������������������������������������������������������������������������������������������������������������������������
function SkillCooldown_LeiDa5( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 
function SkillArea_Square_LeiDa5( sklv )
        local sklv = 5
	local side = 50 + sklv * 300 
	SetSkillRange ( 3 , side ) 	
end 
function SkillArea_State_LeiDa5 ( sklv )
        local sklv = 5
	local statetime = 15 + sklv *55   
	local statelv = sklv 
	SetRangeState ( STATE_LEIDA , statelv  , statetime ) 						
end 
function Skill_LeiDa5_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE 
		then
			SkillUnable(role)
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			return 0
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2812 ) --�״�5
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		
	end 
	local a = DelBagItem ( atk_role , 2812 , 1 )  
	 
end
function Skill_LeiDa5_End ( ATKER , DEFER , sklv ) 
end 


--�����޸�LV1--------------------------------------------------------------------------
function SkillCooldown_ChuanTiXiuFu1( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_ChuanTiXiuFu1_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 1150 ) --�����޸�1
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 1150 , 1 )  
	 
end
function Skill_ChuanTiXiuFu1_End ( ATKER , DEFER , sklv ) 
        local sklv = 1
	local hpdmg = -math.random ( 450 , 650 )*( sklv * 1.5 )   
	Hp_Endure_Dmg ( DEFER , hpdmg ) 
	ALLExAttrSet(role)
end
function State_ChuanTiXiuFu_Add ( role , statelv )
end 
function State_ChuanTiXiuFu_Rem ( role , statelv ) 
end

--�����޸�LV2--------------------------------------------------------------------------
function SkillCooldown_ChuanTiXiuFu2( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_ChuanTiXiuFu2_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2734 ) --�����޸�2
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2734 , 1 )  
	 
end
function Skill_ChuanTiXiuFu2_End ( ATKER , DEFER , sklv ) 
        local sklv = 2
	local hpdmg = -math.random ( 450 , 650 )*( sklv * 1.5 )   
	Hp_Endure_Dmg ( DEFER , hpdmg ) 
	ALLExAttrSet(role)
end

--�����޸�LV3--------------------------------------------------------------------------
function SkillCooldown_ChuanTiXiuFu3( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_ChuanTiXiuFu3_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2758 ) --�����޸�3
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2758 , 1 )  
	 
end
function Skill_ChuanTiXiuFu3_End ( ATKER , DEFER , sklv ) 
        local sklv = 3
	local hpdmg = -math.random ( 450 , 650 )*( sklv * 1.5 )   
	Hp_Endure_Dmg ( DEFER , hpdmg ) 
	ALLExAttrSet(role)
end

--�����޸�LV4--------------------------------------------------------------------------
function SkillCooldown_ChuanTiXiuFu4( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_ChuanTiXiuFu4_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2782 ) --�����޸�4
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2782 , 1 )  
	 
end
function Skill_ChuanTiXiuFu4_End ( ATKER , DEFER , sklv ) 
        local sklv = 4
	local hpdmg = -math.random ( 450 , 650 )*( sklv * 1.5 )  
	Hp_Endure_Dmg ( DEFER , hpdmg ) 
	ALLExAttrSet(role)
end


--�����޸�LV5--------------------------------------------------------------------------
function SkillCooldown_ChuanTiXiuFu5( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_ChuanTiXiuFu5_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2806 ) --�����޸�5
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2806 , 1 )  
	 
end
function Skill_ChuanTiXiuFu5_End ( ATKER , DEFER , sklv ) 
        local sklv = 5
	local hpdmg = -math.random ( 450 , 650 )*( sklv * 1.5 )   
	Hp_Endure_Dmg ( DEFER , hpdmg ) 
	ALLExAttrSet(role)
end


--ʳ������LV1--------------------------------------------------------------------------

function SkillCooldown_ShiWuZaiSheng1( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_ShiWuZaiSheng1_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 1151 ) --ʳ������1
	if item_count <= 0 
	then  
		SkillUnable(atk_role)  
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 1151 , 1 )  
	 
end

function Skill_ShiWuZaiSheng1_End ( ATKER , DEFER , sklv ) 
        local sklv = 1
	local sp_sum = 650 * sklv
        local sp = GetChaAttr(DEFER, ATTR_SP) 
	sp=sp+sp_sum
	mxsp = GetChaAttr(DEFER,ATTR_MXSP) 
	if sp > mxsp 
	then    
	   sp = mxsp                       --�ӳ������spʱ����Ϊ���sp
        end 
	SetCharaAttr ( sp , DEFER , ATTR_SP ) 
end
	
function State_ShiWuZaiSheng_Add ( role , statelv ) 
end 
function State_ShiWuZaiSheng_Rem ( role , statelv ) 
end
--ʳ������LV2--------------------------------------------------------------------------

function SkillCooldown_ShiWuZaiSheng2( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_ShiWuZaiSheng2_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2735 ) --ʳ������2
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2735 , 1 )  
	 
end

function Skill_ShiWuZaiSheng2_End ( ATKER , DEFER , sklv ) 
        local sklv = 2
	local sp_sum = 650 * sklv
        local sp = GetChaAttr(DEFER, ATTR_SP) 
	sp=sp+sp_sum
	mxsp = GetChaAttr(DEFER,ATTR_MXSP) 
	if sp > mxsp 
	then    
	   sp = mxsp                       --�ӳ������spʱ����Ϊ���sp
        end 
	SetCharaAttr ( sp , DEFER , ATTR_SP ) 
end
	

--ʳ������LV3--------------------------------------------------------------------------

function SkillCooldown_ShiWuZaiSheng3( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_ShiWuZaiSheng3_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2759 ) --ʳ������3
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2759 , 1 )  
	 
end

function Skill_ShiWuZaiSheng3_End ( ATKER , DEFER , sklv ) 
        local sklv = 3
	local sp_sum = 650 * sklv
        local sp = GetChaAttr(DEFER, ATTR_SP) 
	sp=sp+sp_sum
	mxsp = GetChaAttr(DEFER,ATTR_MXSP) 
	if sp > mxsp 
	then    
	   sp = mxsp                       --�ӳ������spʱ����Ϊ���sp
        end 
	SetCharaAttr ( sp , DEFER , ATTR_SP ) 
end
	

--ʳ������LV4--------------------------------------------------------------------------

function SkillCooldown_ShiWuZaiSheng4( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_ShiWuZaiSheng4_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2783 ) --ʳ������4
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2783 , 1 )  
	 
end

function Skill_ShiWuZaiSheng4_End ( ATKER , DEFER , sklv ) 
        local sklv = 4
	local sp_sum = 650 * sklv
        local sp = GetChaAttr(DEFER, ATTR_SP) 
	sp=sp+sp_sum
	mxsp = GetChaAttr(DEFER,ATTR_MXSP) 
	if sp > mxsp 
	then    
	   sp = mxsp                       --�ӳ������spʱ����Ϊ���sp
        end 
	SetCharaAttr ( sp , DEFER , ATTR_SP ) 
end
	

--ʳ������LV5--------------------------------------------------------------------------

function SkillCooldown_ShiWuZaiSheng5( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_ShiWuZaiSheng5_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2807 ) --ʳ������5
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2807 , 1 )  
	 
end

function Skill_ShiWuZaiSheng5_End ( ATKER , DEFER , sklv ) 
        local sklv = 5
	local sp_sum = 650 * sklv
        local sp = GetChaAttr(DEFER, ATTR_SP) 
	sp=sp+sp_sum
	mxsp = GetChaAttr(DEFER,ATTR_MXSP) 
	if sp > mxsp 
	then    
	   sp = mxsp                       --�ӳ������spʱ����Ϊ���sp
        end 
	SetCharaAttr ( sp , DEFER , ATTR_SP ) 
end
	


--��ʴ��LV1--------------------------------------------------------------------------

function SkillCooldown_FuShiDan1( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_FuShiDan1_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 1152 ) --��ʴ��1
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 1152 , 1 )  
	 
end

function Skill_FuShiDan1_End ( ATKER , DEFER , sklv ) 
        local sklv = 1    
	local statelv = sklv
	local statetime = 2 + sklv*8
        AddState ( ATKER , DEFER , STATE_FSD , statelv , statetime )
end
	
function State_FuShiDan_Add ( role , statelv ) 
        
	local sp_sum = -80
        local sp = GetChaAttr(role, ATTR_SP) 
	sp=sp+sp_sum
	if sp < 0 
	then    
	   sp = 0                       
        end 
	SetCharaAttr ( sp , role , ATTR_SP ) 
	ALLExAttrSet(role)
end 

function State_FuShiDan_Rem ( role , statelv ) 
end
--��ʴ��LV2--------------------------------------------------------------------------

function SkillCooldown_FuShiDan2( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_FuShiDan2_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2736 ) --��ʴ��2
	if item_count <= 0 
	then  
		SkillUnable(atk_role)  
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2736 , 1 )  
	 
end

function Skill_FuShiDan2_End ( ATKER , DEFER , sklv ) 
        local sklv = 2    
	local statelv = sklv
	local statetime = 2 + sklv*8
        AddState ( ATKER , DEFER , STATE_FSD , statelv , statetime )
end
	

--��ʴ��LV3--------------------------------------------------------------------------

function SkillCooldown_FuShiDan3( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_FuShiDan3_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2760 ) --��ʴ��3
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2760 , 1 )  
	 
end

function Skill_FuShiDan3_End ( ATKER , DEFER , sklv ) 
        local sklv = 3    
	local statelv = sklv
	local statetime = 2 + sklv*8
        AddState ( ATKER , DEFER , STATE_FSD , statelv , statetime )
end
	

--��ʴ��LV4--------------------------------------------------------------------------

function SkillCooldown_FuShiDan4( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_FuShiDan4_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2784 ) --��ʴ��4
	if item_count <= 0 
	then  
		SkillUnable(atk_role)  
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2784 , 1 )  
	 
end

function Skill_FuShiDan4_End ( ATKER , DEFER , sklv ) 
        local sklv = 4    
	local statelv = sklv
	local statetime = 2 + sklv*8
        AddState ( ATKER , DEFER , STATE_FSD , statelv , statetime )
end
	

--��ʴ��LV5--------------------------------------------------------------------------

function SkillCooldown_FuShiDan5( sklv ) 
	local Cooldown = 3000 
	return Cooldown 
end 

function Skill_FuShiDan5_Begin ( role , Item ) 
	local NocLock =	KitbagLock( role, 0 )
		if NocLock == LUA_FALSE then
			CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
			SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
			SkillUnable(role)
			return
		end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 2808 ) --��ʴ��5
	if item_count <= 0 
	then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end 
	local a = DelBagItem ( atk_role , 2808 , 1 )  
	 
end

function Skill_FuShiDan5_End ( ATKER , DEFER , sklv ) 
        local sklv = 5    
	local statelv = sklv
	local statetime = 2 + sklv*8
        AddState ( ATKER , DEFER , STATE_FSD , statelv , statetime )
end
	



--��ֻˮ��LV1--------------------------------------------------------------------------
function SkillArea_Circle_Czsl1 ( sklv )
        local sklv=1
	local side = 650 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Czsl1( sklv )
	local Cooldown = 6000
	return Cooldown
end

--function SkillArea_State_Czsl1 ( sklv )
--
--        local sklv = 1
--	local statetime = sklv + 3
--	local statelv = sklv  
--	SetRangeState ( STATE_Slrs , statelv  , statetime ) 									
--end  
function Skill_Czsl1_Begin ( role , sklv ) 

end 

function Skill_Czsl1_End ( ATKER , DEFER , sklv ) 
 
        local sklv=1
	local statetime = sklv + 3
	local statelv = sklv
	if ValidCha(ATKER) == 0 then 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		return 
	end 
	local dmg = 20 
	Hp_Endure_Dmg ( DEFER , dmg ) 
	SetCharaAttr ( 4 , ATKER , ATTR_HP ) 
	AddState ( ATKER , ATKER , STATE_Slrs , statelv , statetime ) 
	AddState ( ATKER , DEFER , STATE_Slrs , statelv , statetime )
end 
function State_Slrs_Add ( role , statelv ) 
        
	local hpdmg =  statelv * 2 
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role) 
	
end 
function State_Slrs_Rem ( role , statelv ) 
end 
function State_Slrs_Tran ( statelv ) 
	return 1
end

--��ֻˮ��LV2--------------------------------------------------------------------------
function SkillArea_Circle_Czsl2 ( sklv )
        local sklv=2
	local side = 650 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Czsl2( sklv )
	local Cooldown = 6000
	return Cooldown
end

--function SkillArea_State_Czsl2 ( sklv )
--
--        local sklv = 2
--	local statetime = sklv + 3
--	local statelv = sklv  
--	SetRangeState ( STATE_Slrs , statelv  , statetime ) 									
--end  
function Skill_Czsl2_Begin ( role , sklv ) 

end 

function Skill_Czsl2_End ( ATKER , DEFER , sklv ) 
 
        local sklv=2
	local statetime = sklv + 3
	local statelv = sklv
	if ValidCha(ATKER) == 0 then 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		return 
	end 
	local dmg = 40
	Hp_Endure_Dmg ( DEFER , dmg ) 
	SetCharaAttr ( 8 , ATKER , ATTR_HP ) 
	AddState ( ATKER , ATKER , STATE_Slrs , statelv , statetime ) 
	AddState ( ATKER , DEFER , STATE_Slrs , statelv , statetime ) 
end 



--��ֻˮ��LV3--------------------------------------------------------------------------
function SkillArea_Circle_Czsl3 ( sklv )
        local sklv=3
	local side = 650 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Czsl3( sklv )
	local Cooldown = 6000
	return Cooldown
end

--function SkillArea_State_Czsl3 ( sklv )
--
--        local sklv = 3
--	local statetime = sklv + 3
--	local statelv = sklv  
--	SetRangeState ( STATE_Slrs , statelv  , statetime ) 									
--end  
function Skill_Czsl3_Begin ( role , sklv ) 

end 

function Skill_Czsl3_End ( ATKER , DEFER , sklv ) 
 
        local sklv=3
	local statetime = sklv + 3
	local statelv = sklv
	if ValidCha(ATKER) == 0 then 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		return 
	end 
	local dmg = 60 
	Hp_Endure_Dmg ( DEFER , dmg ) 
	SetCharaAttr ( 12 , ATKER , ATTR_HP ) 
	AddState ( ATKER , ATKER , STATE_Slrs , statelv , statetime ) 
	AddState ( ATKER , DEFER , STATE_Slrs , statelv , statetime ) 
end 




--��ֻˮ��LV4--------------------------------------------------------------------------
function SkillArea_Circle_Czsl4 ( sklv )
        local sklv=4
	local side = 650 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Czsl4( sklv )
	local Cooldown = 6000
	return Cooldown
end

--function SkillArea_State_Czsl4 ( sklv )
--
--        local sklv = 4
--	local statetime = sklv + 3
--	local statelv = sklv  
--	SetRangeState ( STATE_Slrs , statelv  , statetime ) 									
--end  
function Skill_Czsl4_Begin ( role , sklv ) 

end 

function Skill_Czsl4_End ( ATKER , DEFER , sklv ) 
 
        local sklv=4
	local statetime = sklv + 3
	local statelv = sklv
	if ValidCha(ATKER) == 0 then 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		return 
	end 
	local dmg = 80
	Hp_Endure_Dmg ( DEFER , dmg ) 
	SetCharaAttr ( 16 , ATKER , ATTR_HP ) 
	AddState ( ATKER , ATKER , STATE_Slrs , statelv , statetime ) 
	AddState ( ATKER , DEFER , STATE_Slrs , statelv , statetime )
end 



--��ֻˮ��LV5--------------------------------------------------------------------------
function SkillArea_Circle_Czsl5 ( sklv )
        local sklv=5
	local side = 650 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )   
end 

function SkillCooldown_Czsl5( sklv )
	local Cooldown = 6000
	return Cooldown
end

--function SkillArea_State_Czsl5 ( sklv )
--
--        local sklv = 5
--	local statetime = sklv + 3
--	local statelv = sklv  
--	SetRangeState ( STATE_Slrs , statelv  , statetime ) 									
--end  
function Skill_Czsl5_Begin ( role , sklv ) 

end 

function Skill_Czsl5_End ( ATKER , DEFER , sklv ) 
 
        local sklv=5
	local statetime = sklv + 3
	local statelv = sklv

	if ValidCha(ATKER) == 0 then 
		return 
	end 
	if ValidCha(DEFER) == 0 then 
		return 
	end 
	local dmg = 100
	Hp_Endure_Dmg ( DEFER , dmg ) 
	SetCharaAttr ( 20 , ATKER , ATTR_HP ) 
	AddState ( ATKER , ATKER , STATE_Slrs , statelv , statetime ) 
	AddState ( ATKER , DEFER , STATE_Slrs , statelv , statetime ) 
end 
----------------�Ա�����LV1

function SkillSp_Myzb1 ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end 

function SkillArea_Circle_Myzb1 ( sklv )
        
	local sklv=1
	local side = 550 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )  
end

--function SkillArea_State_Myzb1 ( sklv )
--        local sklv = 1
--	local statetime = sklv + 3
--	local statelv = sklv  
--	SetRangeState ( STATE_Myrs , statelv  , statetime ) 	
--	       
--end  

function SkillCooldown_Myzb1( sklv )
	local Cooldown = 6000
	return Cooldown
end

function Skill_Myzb1_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Myzb1 ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
		

function Skill_Myzb1_End ( ATKER , DEFER , sklv )
        
	local sklv = 1
	local statetime = sklv + 3
	local statelv = sklv  
	local dmg = 20 
	Hp_Endure_Dmg ( DEFER , dmg )
        SetCharaAttr ( 2 , ATKER , ATTR_HP ) 
	AddState ( ATKER , ATKER , STATE_Myrs , statelv , statetime )
	AddState ( ATKER , DEFER , STATE_Myrs , statelv , statetime )
	 
end 

function State_Myrs_Add ( role , statelv ) 

	local hpdmg = statelv * 2  
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role) 

end 
function State_Myrs_Rem ( role , statelv ) 
end 
function State_Myrs_Tran ( statelv ) 
	return 1   
end 
----------------�Ա�����LV2

function SkillSp_Myzb2 ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end 

function SkillArea_Circle_Myzb2 ( sklv )
        
	local sklv=2
	local side = 550 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )  
end

--function SkillArea_State_Myzb2 ( sklv )
--        local sklv = 2
--	local statetime = sklv + 3
--	local statelv = sklv  
--	SetRangeState ( STATE_Myrs , statelv  , statetime ) 									
--end  

function SkillCooldown_Myzb2( sklv )
	local Cooldown = 6000
	return Cooldown
end

function Skill_Myzb2_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Myzb1 ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
		

function Skill_Myzb2_End ( ATKER , DEFER , sklv )
        
	local sklv = 2
	local statetime = sklv + 3
	local statelv = sklv  
	local dmg = 40 
	Hp_Endure_Dmg ( DEFER , dmg )
        SetCharaAttr ( 8 , ATKER , ATTR_HP ) 
	AddState ( ATKER , ATKER , STATE_Myrs , statelv , statetime )
	AddState ( ATKER , DEFER , STATE_Myrs , statelv , statetime )
end 


------------------�Ա�����LV3

function SkillSp_Myzb3 ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end 

function SkillArea_Circle_Myzb3 ( sklv )
        
	local sklv=3
	local side = 550 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )  
end

--function SkillArea_State_Myzb3 ( sklv )
--        local sklv = 3
--	local statetime = sklv + 3
--	local statelv = sklv  
--	SetRangeState ( STATE_Myrs , statelv  , statetime ) 									
--end  

function SkillCooldown_Myzb3( sklv )
	local Cooldown = 6000
	return Cooldown
end

function Skill_Myzb3_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Myzb1 ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
		

function Skill_Myzb3_End ( ATKER , DEFER , sklv )
        
	local sklv = 3
	local statetime = sklv + 3
	local statelv = sklv  
	local dmg = 60
	Hp_Endure_Dmg ( DEFER , dmg )
        SetCharaAttr ( 12 , ATKER , ATTR_HP ) 
	AddState ( ATKER , ATKER , STATE_Myrs , statelv , statetime )
	AddState ( ATKER , DEFER , STATE_Myrs , statelv , statetime )
end 
 
----------------�Ա�����LV4

function SkillSp_Myzb4 ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end 

function SkillArea_Circle_Myzb4 ( sklv )
        
	local sklv=4
	local side = 550 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )  
end

--function SkillArea_State_Myzb4 ( sklv )
--        local sklv = 4
--	local statetime = sklv + 3
--	local statelv = sklv  
--	SetRangeState ( STATE_Myrs , statelv  , statetime ) 									
--end  

function SkillCooldown_Myzb4( sklv )
	local Cooldown = 6000
	return Cooldown
end

function Skill_Myzb4_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Myzb1 ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
		

function Skill_Myzb4_End ( ATKER , DEFER , sklv )
        
	local sklv = 4
	local statetime = sklv + 3
	local statelv = sklv  
	local dmg = 80
	Hp_Endure_Dmg ( DEFER , dmg )
        SetCharaAttr ( 16 , ATKER , ATTR_HP ) 
	AddState ( ATKER , ATKER , STATE_Myrs , statelv , statetime )
	AddState ( ATKER , DEFER , STATE_Myrs , statelv , statetime )
end 


----------------�Ա�����LV5

function SkillSp_Myzb5 ( sklv )										
	local sp_reduce = 20 
	return sp_reduce 
end 

function SkillArea_Circle_Myzb5 ( sklv )
        
	local sklv=5
	local side = 400 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )  
end

--function SkillArea_State_Myzb5 ( sklv )
--        local sklv = 5
--	local statetime = sklv + 3
--	local statelv = sklv  
--	SetRangeState ( STATE_Myrs , statelv  , statetime ) 									
--end  

function SkillCooldown_Myzb5( sklv )
	local Cooldown = 6000
	return Cooldown
end

function Skill_Myzb5_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_Myzb1 ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
		

function Skill_Myzb5_End ( ATKER , DEFER , sklv )
        
	local sklv = 5
	local statetime = sklv + 3
	local statelv = sklv  
	local dmg = 100
	Hp_Endure_Dmg ( DEFER , dmg )
        SetCharaAttr ( 20 , ATKER , ATTR_HP ) 
	AddState ( ATKER , ATKER , STATE_Myrs , statelv , statetime )
	AddState ( ATKER , DEFER , STATE_Myrs , statelv , statetime )
end 



--------����������������������������������������������������������������������������������������������������������������������������������������������������������

function Skill_JST_End ( ATKER , DEFER , sklv ) 

		local  sklv = 1
	        local statelv = sklv
	        local statetime = 3 
		AddState ( ATKER , DEFER , STATE_LST , statelv , statetime ) 
end 

function State_JST_Add( role , statelv ) 
        
        local statelv = 1
	local mspdsa_dif =  0.5 * statelv
	--local mspdsa_dif = 1 
	local mspdsa = math.floor (  (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX ) 
	
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 

function State_JST_Rem( role , statelv ) 
        local statelv = 1
	local mspdsa_dif =  0.5 * statelv
	--local mspdsa_dif = 1
	local mspdsa = math.floor (  (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX ) 
        SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end

---------��ħ��--------------------------------------------------------------------------

function Skill_XMT_End ( ATKER , DEFER , sklv ) 
         
	--local statelv = 1
	--local statetime = 1
	local dmg = 800
	local sklv = 1
	local sp_sum = -50
        local sp = GetChaAttr(DEFER, ATTR_SP) 
	sp=sp+sp_sum
	if sp <= 0 
	then    
	   sp = 0
	   Hp_Endure_Dmg ( DEFER , dmg ) 
        end 
	SetCharaAttr ( sp , DEFER , ATTR_SP ) 
	ALLExAttrSet(DEFER)
        --AddState ( ATKER , DEFER , STATE_FSD , statelv , statetime )
end


----���߳���-------------------------------------------------------------------------------------

function Skill_FeiShe_End ( ATKER , DEFER , sklv ) 
	
	
	local dmg = 2000
	Hp_Endure_Dmg ( DEFER , dmg )  

end 

 ---�����̢------------------------------------------------------------

function Skill_JSBT_End ( ATKER , DEFER , sklv )
	local Sta_role = Sta ( DEFER ) 
	hpdmg =300 +  math.max ( 50 , ( 150 - Sta_role ) )  * 10
		Hp_Endure_Dmg ( DEFER, hpdmg )
end 
 
-- --ħ������---------------------------------------------------------------
--
--function Skill_Mfmy_Use( role , sklv ) 
--
--        AddState ( role , role , STATE_MFMY , 10 , -1 )
--       
--end 
--
--function Skill_Mfmy_Unuse( role , sklv ) 
-- 
--       RemoveState ( role , STATE_MFMY )
--end

--�����ӻ�------------------------------------------------------------------

function SkillArea_Line_Hdhj ( sklv )


	local lenth = 1000  
	local width = 200
	SetSkillRange ( 1 , lenth , width  )  
end

function Skill_Hdhj_End ( ATKER , DEFER , sklv ) 
   if GetChaGuildID(DEFER) > 100 and GetChaGuildID(DEFER) <= 200 then
          return 0
   else
        local dmg = math.random ( 1400 , 2500 )
	Hp_Endure_Dmg ( DEFER , dmg ) 
   end
 end

--�����ӻ�------------------------------------------------------------------

function SkillArea_Line_Hjhj ( sklv )


	local lenth = 1000  
	local width = 200
	SetSkillRange ( 1 , lenth , width  )  
end

function Skill_Hjhj_End ( ATKER , DEFER , sklv ) 

  if GetChaGuildID(DEFER) <= 100 and GetChaGuildID(DEFER) > 0 then
      return 0
  else
      local dmg = math.random ( 1400 , 2500 )
      Hp_Endure_Dmg ( DEFER , dmg ) 
  end
end

----�ظ�֮Ȫ-------------------------------------------------------------------------------------

function State_HFZQ_Add( role , statelv ) 
     
        local statelv = 1
        local hp_dif = Mxhp(role) * 0.1 * statelv
	local sp_dif = Mxsp(role) * 0.1 * statelv
	local hp_now = Hp(role) + hp_dif 
	local sp_now = Sp(role) + sp_dif

	SetCharaAttr( hp_now , role , ATTR_HP ) 
	SetCharaAttr( sp_now , role , ATTR_SP ) 
	ALLExAttrSet(role)  
	
end 

function State_HFZQ_Rem( role , statelv ) 
end

----------��ʥ����

function Skill_Shenshenglazhu_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local Item_CanGet = GetChaFreeBagGridNum ( ATKER )	
	if Item_CanGet <= 0 then
		CALCULATE_SKILLEFFECT_LUA_000105 = GetResString("CALCULATE_SKILLEFFECT_LUA_000105")
		SystemNotice(ATKER ,CALCULATE_SKILLEFFECT_LUA_000105)
		UseItemFailed ( ATKER )
		return
	end
	local a = DelBagItem ( ATKER , 3006 , 1 ) 
	if a ~= 1 then
		CALCULATE_SKILLEFFECT_LUA_000106 = GetResString("CALCULATE_SKILLEFFECT_LUA_000106")
		SystemNotice(ATKER, CALCULATE_SKILLEFFECT_LUA_000106)
		return 0
	end
	GiveItem ( ATKER , 0 , 3007 , 1 , 41) 
end 

------Ů�����
function Skill_NSDX_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local role_NSDX = GetChaItem2 ( ATKER , 2 , 3010)
	local Energy_NSDX = GetItemAttr ( role_NSDX , ITEMATTR_ENERGY )
	if Energy_NSDX <999 then
		local Energy_NSDX = Energy_NSDX + 1
		SetItemAttr ( role_NSDX , ITEMATTR_ENERGY , Energy_NSDX )
		RefreshCha( ATKER )
	end
end

----------------��ħ����

function SkillSp_EmoYuYan ( sklv )										
	local sp_reduce = 155
	return sp_reduce
end 

function SkillArea_Circle_EmoYuYan ( sklv )
       
	--local sklv=1
	local side = 550 + math.floor ( sklv * 50 ) 
	SetSkillRange ( 4 , side )  
end


function SkillCooldown_EmoYuYan( sklv )
	local Cooldown = 30000
	return Cooldown
end

function Skill_EmoYuYan_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce = SkillSp_EmoYuYan ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 
		

function Skill_EmoYuYan_End ( ATKER , DEFER , sklv )
        
	
	
	--local sklv = 1
	local statetime = 20
	local statelv = sklv 
	local dmg = 1050+300*sklv 
	Hp_Endure_Dmg ( DEFER , dmg )
	AddState ( ATKER , DEFER , STATE_EMYY , statelv , statetime )
			 
end 

function State_EmoYuYan_Add ( role , statelv ) 

	local hpdmg = 120 + statelv * 30 
	Hp_Endure_Dmg ( role , hpdmg ) 
	ALLExAttrSet(role) 

end 
function State_EmoYuYan_Rem ( role , statelv ) 
end

--------------------��ʥ����--------------------------------

function SkillArea_Circle_SSSP( sklv )									
	local side = 1000 
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_SSSP( sklv )
	local Cooldown = 30000
	return Cooldown
end

function SkillSp_SSSP ( sklv )										
	local sp_reduce = 120 + sklv * 20     
	return sp_reduce 
end 



function Skill_SSSP_Begin ( role , sklv ) 
   
        

	local sp = Sp(role) 
	local sp_reduce = SkillSp_SSSP ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_SSSP_End ( ATKER , DEFER , sklv )
	local dmg_1 = 1440 + sklv*360
	local dmg_2 = -800 - sklv*200
	local reg1 = 0
	reg1 =IsChaInRegion( ATKER, 2 )
	if reg1 == 1 then
		dmg_1 = 0
	end
	local reg2 = 0
	reg2 =IsChaInRegion( DEFER, 2 )
	if reg2 == 1 then
		dmg_1 = 0
	end
	if is_friend(ATKER, DEFER) == 0 then
	   Hp_Endure_Dmg ( DEFER , dmg_1 ) 
	else
	   Hp_Endure_Dmg ( DEFER , dmg_2 )
	end 
		
end 


------------------���޻�--------------------------

function SkillSp_ShouWangS ( sklv )										
	local sp_reduce = 125  
	return sp_reduce 
end

function SkillCooldown_ShouWangS( sklv )
	local Cooldown = 30000
	return Cooldown
end

function SkillArea_Circle_ShouWangS ( sklv )					
	local side = 800
	SetSkillRange ( 4 , side  ) 	
end 

function Skill_ShouWangS_Begin ( role , sklv ) 
	
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_ShouWangS ( sklv )	
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		
		return 
	end 
	Sp_Red (role , sp_reduce ) 
	
end 

function Skill_ShouWangS_End ( ATKER , DEFER , sklv ) 


        local dmg = 2000 + sklv * 500
	Hp_Endure_Dmg ( DEFER , dmg ) 
		
end 




-------�����ڡ���������������������������������������������������������������

function SkillArea_Line_ArfGX ( sklv )										
	local lenth = 900 + sklv * 30  
	local width = 250 + sklv * 10 
	SetSkillRange ( 1 , lenth , width  )  
end

function SkillCooldown_ArfGX( sklv )
	local Cooldown = 30000
	return Cooldown
end

function SkillSp_ArfGX ( sklv )										
	local sp_reduce = 105   
	return sp_reduce 
end


function Skill_ArfGX_Begin ( role , sklv ) 
	local sp = Sp(role) 
	local sp_reduce  = SkillSp_ArfGX ( sklv )  
	if sp - sp_reduce < 0 then 
		SkillUnable(role) 
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_ArfGX_End ( ATKER , DEFER , sklv ) 

        local dmg = 2000 + sklv * 500 
        Hp_Endure_Dmg ( DEFER , dmg ) 
		
end 
--------------------��Ӱն--------------------------------

 function SkillArea_Circle_WuYin( sklv )							
	local side = 800 
	SetSkillRange ( 4 , side  )  
end 

function SkillCooldown_WuYin( sklv )
	local Cooldown = 30000
	return Cooldown
end

function SkillSp_WuYin ( sklv )										
	local sp_reduce = 125  
	return sp_reduce 
end 

function Skill_WuYin_Begin ( role , sklv ) 

	local sp = Sp(role) 
	local sp_reduce = SkillSp_WuYin ( sklv ) 
	if sp - sp_reduce < 0 then 
		SkillUnable(role)   
		return 
	end 
	Sp_Red (role , sp_reduce ) 
end 

function Skill_WuYin_End ( ATKER , DEFER , sklv ) 

        local dmg = 1760 + sklv * 440
	Hp_Endure_Dmg ( DEFER , dmg ) 

end 


------------------������--------------------------

function SkillSp_XYSYF ( sklv )										
	local sp_reduce = 160  
	return sp_reduce 
end

function SkillCooldown_XYSYF( sklv )
	local Cooldown = 30000
	return Cooldown
end

function SkillArea_Circle_XYSYF ( sklv )					
	local side = 800 
	SetSkillRange ( 4 , side  ) 	
end 

function SkillArea_State_XYSYF ( sklv )										
	local statetime = 15 
	local statelv = sklv 
	--Notice("come here")
	SetRangeState ( STATE_YNZL , statelv  , statetime ) 									
end 

function Skill_XYSYF_Begin ( role , sklv ) 
	
	local sp = Sp(role) 
	local sp_reduce 
	sp_reduce = SkillSp_XYSYF ( sklv )	
	if sp - sp_reduce < 0 then 
		SkillUnable(role)  
		
		return 
	end 
	Sp_Red (role , sp_reduce )
	
end 

function Skill_XYSYF_End ( ATKER , DEFER , sklv ) 
end 

function State_XYSYF_Add ( role , statelv ) 
	
	local dmg =  600 + statelv * 300 
	Hp_Endure_Dmg ( role , dmg ) 
end 

function State_XYSYF_Rem ( role , statelv ) 

end 

function State_XYSYF_Tran ( statelv )
	return 3
end

--���ܱ�����������������������������������������������������������������������������������������������������������������������������������������������������������������


function SkillArea_Circle_BDH ( sklv )									
	local side = 500 
	SetSkillRange ( 4 , side  ) 
end 

function Skill_BDH_Begin ( role , sklv ) 
	
end 

function Skill_BDH_End ( ATKER , DEFER , sklv ) 
	
	local sklv = 1
	local statelv = sklv 
	local statetime = 5
	AddState ( ATKER , DEFER , STATE_BDH , statelv , statetime )
end 

function State_BDH_Add ( role , statelv )

        local statelv = 1
        local mspdsa_dif =  0.5 * statelv
	local aspdsa_dif = 0.6
	local mspdsa = math.floor (  (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX ) 
	local aspdsa = ( AspdSa(role) - aspdsa_dif) * ATTR_RADIX
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 



function State_BDH_Rem ( role , statelv ) 


        local statelv = 1
        local mspdsa_dif =  0.5 * statelv
	local aspdsa_dif = 0.6
	local mspdsa = math.floor (  (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX ) 
	local aspdsa = ( AspdSa(role) + aspdsa_dif) * ATTR_RADIX
	SetCharaAttr( aspdsa , role , ATTR_STATEC_ASPD )
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)  
end 
-- ������----10���Ӽӷ���
function State_DHZ_Add ( role , statelv )
	local def_dif = 60
	local defsb = DefSb( role ) + def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end

function State_DHZ_Rem ( role , statelv )
	local def_dif = 60
	local defsb = DefSb( role ) - def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end


--��ɳ��-----�����������ٶȵĵ��߳���ʱ��15����

function State_DSZ_Add ( role , statelv )
	local mspdsa_dif = 0.20
	local mspdsa = MspdSa ( role )---------
	local mspdsa_fin = ( mspdsa + mspdsa_dif ) * ATTR_RADIX
	SetCharaAttr( mspdsa_fin , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)
end

function State_DSZ_Rem ( role , statelv )
	local mspdsa_dif = 0.20
	local mspdsa = MspdSa ( role )
	local mspdsa_fin = ( mspdsa - mspdsa_dif ) * ATTR_RADIX
	SetCharaAttr( mspdsa_fin , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)
end


--===========================���Ӱ�����״̬=======================
function State_Ilovedad_Add( role ,  statelv )
--	SystemNotice(role ,"I'm in")
	
end

function State_Ilovedad_Rem( role ,  statelv )
--	SystemNotice(role ,"I'm out")

end

------------------------------------------------���������ָ�ҩ��(kokora)---------------------------------
function Skill_thewdrug_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( atk_role , 1075 ) --���������ָ�ҩ��
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 1075 , 1 ) 
end
	
function Skill_thewdrug_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local statelv = 7

	local ChaStateLv = GetChaStateLv ( ATKER , STATE_HPHMHF )
	if ChaStateLv > statelv then
		CALCULATE_ITEMEFFECT_LUA_000251 = GetResString("CALCULATE_ITEMEFFECT_LUA_000251")
		SystemNotice ( ATKER , CALCULATE_ITEMEFFECT_LUA_000251 )
		UseItemFailed ( ATKER )
		return 0
	end
	local statetime = 10
	AddState( ATKER , DEFER , STATE_HPHMHF , statelv , statetime )
	CALCULATE_SKILLEFFECT_LUA_000107 = GetResString("CALCULATE_SKILLEFFECT_LUA_000107")
	SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000107 )
	SystemNotice ( ATKER ,"ATKER="..ATKER )
	SystemNotice ( ATKER ,"DEFER="..DEFER )
end

------------------------------------------------̩̹ҩ��(kokora)---------------------------------
function Skill_thaitdrug_Begin ( role , sklv )
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 
	end
	local item_count = CheckBagItem ( atk_role , 1098 ) --̩̹ҩ��
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 1098 , 1 )
	end
function Skill_thaitdrug_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 
	end
	local statelv = 8
	local ChaStateLv = GetChaStateLv ( ATKER , STATE_HPHMHF )
	if ChaStateLv > statelv then
		CALCULATE_ITEMEFFECT_LUA_000251 = GetResString("CALCULATE_ITEMEFFECT_LUA_000251")
		SystemNotice ( ATKER , CALCULATE_ITEMEFFECT_LUA_000251 )
		UseItemFailed ( ATKER )
		return
	end
	local statetime = 10
	AddState( ATKER , DEFER , STATE_HPHMHF , statelv , statetime )
	CALCULATE_SKILLEFFECT_LUA_000108 = GetResString("CALCULATE_SKILLEFFECT_LUA_000108")
	SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000108 )
end
----------------------------------------�������˼�------------------------------------
--�����ָ�������--

function STATE_HPHMHF_Add ( role , statelv)
	local hp_now = GetChaAttr( role , ATTR_HP )
	local hp_resume = 0
	if statelv == 1 then
		hp_resume = 20
	elseif statelv == 2 then
		hp_resume = 50
	elseif statelv == 3 then
		hp_resume = 100
	elseif statelv == 4 then
		hp_resume = 110
	elseif statelv == 5 then
		hp_resume = 150
	elseif statelv == 6 then
		hp_resume = 190
	elseif statelv == 7 then
		hp_resume = 300
	elseif statelv == 8 then
		hp_resume = 1000
	end


	if hp_now <= 0 then						--��������ʱ����ʹ��
		return 0
	end  
	hp_now = hp_now + hp_resume 
	local mxhp = GetChaAttr( role , ATTR_MXHP) 
	if hp_now > mxhp then						--�ӳ������hpʱ����Ϊ���hp
		 hp_now = mxhp 
	 end 
	SetCharaAttr(hp_now, role, ATTR_HP)
end 

function STATE_HPHMHF_Rem ( role , statelv)

end
------------------------------------------------��������(kokora)---------------------------------
function Skill_deitybless_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 
	end
	local item_count = CheckBagItem ( atk_role , 1099 ) --��������
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 1099 , 1 )
	end
function Skill_deitybless_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 
	end
	local statelv = 1
	local ChaStateLv = GetChaStateLv ( ATKER , STATE_SPHMHF )
	if ChaStateLv > statelv then
		CALCULATE_ITEMEFFECT_LUA_000251 = GetResString("CALCULATE_ITEMEFFECT_LUA_000251")
		SystemNotice ( ATKER , CALCULATE_ITEMEFFECT_LUA_000251 )
		UseItemFailed ( ATKER )
		return
	end
	local statetime = 10
	AddState( ATKER , DEFER , STATE_SPHMHF , statelv , statetime )
	CALCULATE_SKILLEFFECT_LUA_000109 = GetResString("CALCULATE_SKILLEFFECT_LUA_000109")
	SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000109 )
end

------------------------------------------------�����ϼ�(kokora)---------------------------------
function Skill_energydrug_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 
	end
	local item_count = CheckBagItem ( atk_role , 1100 ) --�����ϼ�
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 1100 , 1 )
	end
function Skill_energydrug_End( ATKER , DEFER , sklv )
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 
	end
	local statelv = 2
	local ChaStateLv = GetChaStateLv ( ATKER , STATE_SPHMHF )
	if ChaStateLv > statelv then
		CALCULATE_ITEMEFFECT_LUA_000251 = GetResString("CALCULATE_ITEMEFFECT_LUA_000251")
		SystemNotice ( ATKER , CALCULATE_ITEMEFFECT_LUA_000251 )
		UseItemFailed ( ATKER )
		return
	end
	local statetime = 10
	AddState( ATKER , DEFER , STATE_SPHMHF , statelv , statetime )
	CALCULATE_SKILLEFFECT_LUA_000110 = GetResString("CALCULATE_SKILLEFFECT_LUA_000110")
	SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000110 )
end

--�����ָ�������--

function STATE_SPHMHF_Add ( role , statelv)
	local sp_now = GetChaAttr( role , ATTR_SP )
	local hp_now = GetChaAttr( role , ATTR_HP )
	local array={100,500}
	local sp_resume = array[statelv]
	if hp_now <= 0 then						--��������ʱ����ʹ��
		return 0
	end  
	sp_now = sp_now + sp_resume 
	local mxsp = GetChaAttr( role , ATTR_MXSP) 
	if sp_now > mxsp then						--�ӳ������hpʱ����Ϊ���hp
		 sp_now = mxsp 
	 end 
	SetCharaAttr(sp_now, role, ATTR_SP) 
end 


function STATE_XZDLL_Add ( role , statelv)

end
function STATE_XZDLL_Rem ( role , statelv)


end

function STATE_QB_Add ( role , statelv)

end
function STATE_QB_Rem ( role , statelv)


end
--˲��ָ�����������--ħ��֮��

function Skill_dragonheart_Begin ( role , sklv ) 
	local atk_role = TurnToCha ( role ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 
	end
	local item_count = CheckBagItem ( atk_role , 1101 ) --ħ��֮��
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( atk_role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( atk_role , 1101 , 1 )
	end
	
function Skill_dragonheart_End ( role)
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local hp_now = GetChaAttr( role , ATTR_HP )
	local mxhp = GetChaAttr( role , ATTR_MXHP)	
	local mxsp = GetChaAttr( role , ATTR_MXSP)
	if hp_now <= 0 then						--��������ʱ����ʹ��
		return 0
	end  
	SetCharaAttr(mxhp, role, ATTR_HP) 
	SetCharaAttr(mxsp, role, ATTR_SP) 
end
-----ǧ��׷Ѱ����Ҫ���˽ڽ�ָ��---------
function Skill_Qlzx_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return
	end
	local item_count = CheckBagItem ( ATKER , 2520 ) --���˽ڽ�ָ
	if item_count <= 0 then  
		CALCULATE_SKILLEFFECT_LUA_000111 = GetResString("CALCULATE_SKILLEFFECT_LUA_000111")
		SystemNotice( ATKER , CALCULATE_SKILLEFFECT_LUA_000111)
		return
	else
		local ring = GetChaItem2 ( ATKER , 2 , 2520 )	--ȡ�����˽ڽ�ָָ��
		local Num_ATK_JZ = GetItemForgeParam ( ring , 1 )
		Num_ATK_JZ = TansferNum ( Num_ATK_JZ )		---����ID��
		local ID_ATK_Num = GetRoleID(ATKER)
--		local RoleType = GetChaID(ATKER)
		local t = {} 
		t[0] = DEFER 
		t[1] = GetTeamCha(DEFER, 0 )  
		t[2] = GetTeamCha(DEFER, 1 )   
		t[3] = GetTeamCha(DEFER, 2 )    
		t[4] = GetTeamCha(DEFER, 3 )
		local i = 1
		for i = 1 , 4 , 1 do
			if t[i] ~= nil then
				local item_count = CheckBagItem ( t[i] , 2520 )	--�����������Ƿ��н�ָ
				if item_count == 1 then  
					local Item = GetChaItem2 ( t[i] , 2 , 2520 )	--ȡ�����˽ڽ�ָָ��
					local Num_JZ = GetItemForgeParam ( Item , 1 )
					Num_JZ = TansferNum ( Num_JZ )
					if Num_JZ == ID_ATK_Num  then
						local ID_Num = GetRoleID(t[i])
						if Num_ATK_JZ==ID_Num then
							local x, y = GetChaPos(t[i])
							local map_name = GetChaMapName (t[i])
							local checkteam = CheckRoleIsInJJCBS ( t[i] )   -------ȡ��ɫ�Ƿ���JJC��
							if checkteam == 0 then
								x = math.floor (x*0.01)
								y = math.floor (y*0.01)
								if map_name == "prisonisland" or map_name == "mingyun" or map_name == "guildwar" or map_name == "guildwar2" or map_name == "darkswamp" or map_name == "abandonedcity" or map_name == "abandonedcity2" or map_name == "abandonedcity3" then
									CALCULATE_SKILLEFFECT_LUA_000112 = GetResString("CALCULATE_SKILLEFFECT_LUA_000112")
									SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000112 )
									UseItemFailed ( ATKER )
									return
								else
									local checkteam2 = CheckRoleIsInJJCBS ( ATKER )   -------ȡ��ɫ�Ƿ���JJC��
									if checkteam2 == 0 then
										local map_name2 = GetChaMapName ( ATKER )
										if map_name2 == "prisonisland" or map_name2 == "mingyun" or map_name2 == "guildwar" or map_name2 == "guildwar2" or map_name2 == "darkswamp" or map_name2 == "abandonedcity" or map_name2 == "abandonedcity2" or map_name2 == "abandonedcity3" then
											CALCULATE_SKILLEFFECT_LUA_000113 = GetResString("CALCULATE_SKILLEFFECT_LUA_000113")
											SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000113 )
											UseItemFailed ( ATKER )
											return
										end
									else 
										CALCULATE_SKILLEFFECT_LUA_000114 = GetResString("CALCULATE_SKILLEFFECT_LUA_000114")
										SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000114)
										return
									end
								end
							else
								CALCULATE_SKILLEFFECT_LUA_000114 = GetResString("CALCULATE_SKILLEFFECT_LUA_000114")
								SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000114)
								return 
							end 
							GoTo(ATKER, x,y, map_name)
							return
						end
					end
				end
			end
			if i == 4 then
				CALCULATE_SKILLEFFECT_LUA_000115 = GetResString("CALCULATE_SKILLEFFECT_LUA_000115")
				SystemNotice( ATKER , CALCULATE_SKILLEFFECT_LUA_000115)
			end
		end
		
--		local Item = GetChaItem2 ( ATKER , 2 , 2520 )	--ȡ�����˽ڽ�ָָ��
--		local Num_JZ = GetItemForgeParam ( Item , 1 )
--		Num_JZ = TansferNum ( Num_JZ )
--		local Part1_JZ = GetNum_Part1 ( Num_JZ )	--Get Num Part 1 �� Part 7
--		local Part2_JZ = GetNum_Part2 ( Num_JZ )	
--		local Part3_JZ = GetNum_Part3 ( Num_JZ )
--		local Part4_JZ = GetNum_Part4 ( Num_JZ )
--		local Part5_JZ = GetNum_Part5 ( Num_JZ )
--		local Part6_JZ = GetNum_Part6 ( Num_JZ )
--		local Part7_JZ = GetNum_Part7 ( Num_JZ )
--		Part1_JZ=1
--			Num_JZ = SetNum_Part1 ( Num_JZ , 1 ) 
--			SetItemForgeParam ( Item , 1 , Num_JZ )

	end
end

-----BBRING1---85BBţ��
function State_BBRING1_Add ( role , statelv ) 
	local strsb_dif = 10
	local strsb = StrSb( role ) + strsb_dif
	SetCharaAttr( strsb , role , ATTR_STATEV_STR )

	local consb_dif = 8
	local consb = ConSb( role ) + consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )

	local defsb_dif = 100
	local defsb = DefSb(role) + defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 

	local fleesb_dif = 10
	local fleesb = FleeSb(role) + fleesb_dif 
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE )
	
	local hitsb_dif = 10
	local hitsb = HitSb(role) + hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local hrecsb_dif = 6
	local hrecsb = HrecSb(role) + hrecsb_dif
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 

	local pdef_dif = 4
	local pdef = ResistSb(role) + pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
end 

function State_BBRING1_Rem ( role , statelv )
	
	local strsb_dif = 10
	local strsb = StrSb( role ) - strsb_dif
	SetCharaAttr( strsb , role , ATTR_STATEV_STR )

	local consb_dif = 8
	local consb = ConSb( role ) - consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	
	local defsb_dif = 100
	local defsb = DefSb(role) - defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 
	
	local fleesb_dif = 10
	local fleesb = FleeSb(role) - fleesb_dif 
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE )
	
	local hitsb_dif = 10
	local hitsb = HitSb(role) - hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local hrecsb_dif = 6
	local hrecsb = HrecSb(role) - hrecsb_dif
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 

	local pdef_dif = 4
	local pdef = ResistSb(role) - pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
end

-----BBRING2---85BB˫��
function State_BBRING2_Add ( role , statelv ) 
	local strsb_dif = 8
	local strsb = StrSb( role ) + strsb_dif
	SetCharaAttr( strsb , role , ATTR_STATEV_STR )

	local agisb_dif = 3
	local agisb = AgiSb( role ) + agisb_dif
	SetCharaAttr( agisb , role , ATTR_STATEV_AGI )
	
	local consb_dif = 8
	local consb = ConSb( role ) + consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )

	local defsb_dif = 80
	local defsb = DefSb(role) + defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 

	local fleesb_dif = 30
	local fleesb = FleeSb(role) + fleesb_dif 
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE )
	
	local hitsb_dif = 10
	local hitsb = HitSb(role) + hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local hrecsb_dif = 8
	local hrecsb = HrecSb(role) + hrecsb_dif
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 

	local pdef_dif = 4
	local pdef = ResistSb(role) + pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
end 

function State_BBRING2_Rem ( role , statelv ) 
	local strsb_dif = 8
	local strsb = StrSb( role ) - strsb_dif
	SetCharaAttr( strsb , role , ATTR_STATEV_STR )

	local agisb_dif = 3
	local agisb = AgiSb( role ) - agisb_dif
	SetCharaAttr( agisb , role , ATTR_STATEV_AGI )
	
	local consb_dif = 8
	local consb = ConSb( role ) - consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )

	local defsb_dif = 80
	local defsb = DefSb(role) - defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 

	local fleesb_dif = 30
	local fleesb = FleeSb(role) - fleesb_dif 
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE )
	
	local hitsb_dif = 10
	local hitsb = HitSb(role) - hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local hrecsb_dif = 8
	local hrecsb = HrecSb(role) - hrecsb_dif
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 

	local pdef_dif = 4
	local pdef = ResistSb(role) - pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
end

-----BBRING3---85BB�Խ�
function State_BBRING3_Add ( role , statelv ) 
	
	local agisb_dif = 4
	local agisb = AgiSb( role ) + agisb_dif
	SetCharaAttr( agisb , role , ATTR_STATEV_AGI )
	
	local dexsb_dif = 8
	local dexsb = DexSb( role ) + dexsb_dif
	SetCharaAttr( dexsb , role , ATTR_STATEV_DEX )
	
	local consb_dif = 6
	local consb = ConSb( role ) + consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	
	local defsb_dif = 75
	local defsb = DefSb(role) + defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 

	local fleesb_dif = 15
	local fleesb = FleeSb(role) + fleesb_dif 
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE )
	
	local hitsb_dif = 30
	local hitsb = HitSb(role) + hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local hrecsb_dif = 6
	local hrecsb = HrecSb(role) + hrecsb_dif
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 

	local pdef_dif = 3
	local pdef = ResistSb(role) + pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
end 

function State_BBRING3_Rem ( role , statelv ) 
	local agisb_dif = 4
	local agisb = AgiSb( role ) - agisb_dif
	SetCharaAttr( agisb , role , ATTR_STATEV_AGI )
	
	local dexsb_dif = 8
	local dexsb = DexSb( role ) - dexsb_dif
	SetCharaAttr( dexsb , role , ATTR_STATEV_DEX )
	
	local consb_dif = 6
	local consb = ConSb( role ) - consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	
	
	local defsb_dif = 75
	local defsb = DefSb(role) - defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 

	local fleesb_dif = 15
	local fleesb = FleeSb(role) - fleesb_dif 
	SetCharaAttr( fleesb , role , ATTR_STATEV_FLEE )
	
	local hitsb_dif = 30
	local hitsb = HitSb(role) - hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local hrecsb_dif = 6
	local hrecsb = HrecSb(role) - hrecsb_dif
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 

	local pdef_dif = 3
	local pdef = ResistSb(role) - pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
end

-----BBRING4---85BB����
function State_BBRING4_Add ( role , statelv ) 
	
	local consb_dif = 8
	local consb = ConSb( role ) + consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	
	local stasb_dif = 10
	local stasb = StaSb( role ) + stasb_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	
	local defsb_dif = 75
	local defsb = DefSb(role) + defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 

	local hitsb_dif = 30
	local hitsb = HitSb(role) + hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local hrecsb_dif = 4
	local hrecsb = HrecSb(role) + hrecsb_dif
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 
	
	local srecsb_dif = 2
	local srecsb = SrecSb(role) + srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 

	local pdef_dif = 3
	local pdef = ResistSb(role) + pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
end 

function State_BBRING4_Rem ( role , statelv ) 
		
	local consb_dif = 8
	local consb = ConSb( role ) - consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	
	local stasb_dif = 10
	local stasb = StaSb( role ) - stasb_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	
	local defsb_dif = 75
	local defsb = DefSb(role) - defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 

	local hitsb_dif = 30
	local hitsb = HitSb(role) - hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local hrecsb_dif = 4
	local hrecsb = HrecSb(role) - hrecsb_dif
	SetCharaAttr( hrecsb , role , ATTR_STATEV_HREC ) 
	
	local srecsb_dif = 2
	local srecsb = SrecSb(role) - srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 

	local pdef_dif = 3
	local pdef = ResistSb(role) - pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
end

-----BBRING5---85BB��ӡ��
function State_BBRING5_Add ( role , statelv ) 
	
	local consb_dif = 7
	local consb = ConSb( role ) + consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	
	local stasb_dif = 10
	local stasb = StaSb( role ) + stasb_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	
	local defsb_dif = 55
	local defsb = DefSb(role) + defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 

	local hitsb_dif = 30
	local hitsb = HitSb(role) + hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local srecsb_dif = 8
	local srecsb = SrecSb(role) + srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 

	local pdef_dif = 2
	local pdef = ResistSb(role) + pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
end 

function State_BBRING5_Rem ( role , statelv ) 
		
	local consb_dif = 7
	local consb = ConSb( role ) - consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	
	local stasb_dif = 10
	local stasb = StaSb( role ) - stasb_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	
	local defsb_dif = 55
	local defsb = DefSb(role) - defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 

	local hitsb_dif = 30
	local hitsb = HitSb(role) - hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local srecsb_dif = 8
	local srecsb = SrecSb(role) - srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 

	local pdef_dif = 2
	local pdef = ResistSb(role) - pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
end

-----BBRING6---85BBʥ��
function State_BBRING6_Add ( role , statelv ) 
	
	local dexsb_dif = 2
	local dexsb = DexSb( role ) + dexsb_dif
	SetCharaAttr( dexsb , role , ATTR_STATEV_DEX )
	
	local consb_dif = 3
	local consb = ConSb( role ) + consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	
	local stasb_dif = 12
	local stasb = StaSb( role ) + stasb_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	
	local defsb_dif = 55
	local defsb = DefSb(role) + defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 

	local hitsb_dif = 30
	local hitsb = HitSb(role) + hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local srecsb_dif = 6
	local srecsb = SrecSb(role) + srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 

	local pdef_dif = 2
	local pdef = ResistSb(role) + pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
	
end 

function State_BBRING6_Rem ( role , statelv ) 
	
	local dexsb_dif = 2
	local dexsb = DexSb( role ) - dexsb_dif
	SetCharaAttr( dexsb , role , ATTR_STATEV_DEX )
	
	local consb_dif = 3
	local consb = ConSb( role ) - consb_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	
	local stasb_dif = 12
	local stasb = StaSb( role ) - stasb_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	
	local defsb_dif = 55
	local defsb = DefSb(role) - defsb_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 

	local hitsb_dif = 30
	local hitsb = HitSb(role) - hitsb_dif
	SetCharaAttr( hitsb , role , ATTR_STATEV_HIT ) 

	local srecsb_dif = 6
	local srecsb = SrecSb(role) - srecsb_dif
	SetCharaAttr( srecsb , role , ATTR_STATEV_SREC ) 

	local pdef_dif = 2
	local pdef = ResistSb(role) - pdef_dif 
	SetCharaAttr( pdef , role , ATTR_STATEV_PDEF )

	ALLExAttrSet(role)  
	
end


--------------------------------------------------------------08��Ʒ����(���ָı�,Ч������)kokora---------------------------------------------------
-------------------------------------------------�캽����--------------------------------------------------------------------
function State_lantern_Add ( role , statelv )
	local def_dif = 100
	local defsb = DefSb( role ) + def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end

function State_lantern_Rem ( role , statelv )
	local def_dif = 100
	local defsb = DefSb( role ) - def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end

--Ѹ�ݻ���ˮ �����������ٶ�С�����ͷ����ĵ��߳���ʱ��5����------------------------------------------------------

function State_rapiddrug_Add ( role , statelv )
	local mspdsa_dif = 0.5
	local def_dif = 50
	local mspdsa = MspdSa ( role )
	local mspdsa_fin = ( mspdsa + mspdsa_dif ) * ATTR_RADIX
	local defsb = DefSb( role ) - def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	SetCharaAttr( mspdsa_fin , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)
end

function State_rapiddrug_Rem ( role , statelv )
	local mspdsa_dif = 0.5
	local def_dif = 50
	local mspdsa = MspdSa ( role )
	local mspdsa_fin = ( mspdsa - mspdsa_dif ) * ATTR_RADIX
	local defsb = DefSb( role ) + def_dif
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	SetCharaAttr( mspdsa_fin , role , ATTR_STATEC_MSPD )
	ALLExAttrSet(role)
end

--ս��ҩ�� ˲����߹�����500ͬʱ����������60����ʱ��10����------------------------------------------------------

function State_warsit_Add ( role , statelv )
	local atksb_dif = 500	
	local def_dif = 60
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	local defsb = DefSb( role ) - def_dif
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end

function State_warsit_Rem ( role , statelv )
	local atksb_dif = 500	
	local def_dif = 60
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	local defsb = DefSb( role ) + def_dif
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	ALLExAttrSet(role)
end

----------------------------------------����װ�� ˲����߹�����100ͬʱ����������30����ʱ��10����--------------------------------------------

function State_darkdress_Add ( role , statelv )
	local def_dif = 100
	local atksb_dif = 30
	local defsb = DefSb( role ) + def_dif
	local mnatksb = MnatkSb(role) - atksb_dif  
	local mxatksb = MxatkSb(role ) - atksb_dif 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)
end

function State_darkdress_Rem ( role , statelv )
	local def_dif = 100
	local atksb_dif = 30
	local defsb = DefSb( role ) - def_dif
	local mnatksb = MnatkSb(role) + atksb_dif  
	local mxatksb = MxatkSb(role ) + atksb_dif 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF )
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet(role)
end

-------------------------------------------------------------------��ħ���(����+10)------------------------------------------------------------

function State_DEMON_Add ( role , statelv )
	local sta_dif = 10
	local stasb = StaSb( role ) + sta_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	ALLExAttrSet(role)
end

function State_DEMON_Rem ( role , statelv )
	local sta_dif = 10
	local stasb = StaSb( role ) - sta_dif
	SetCharaAttr( stasb , role , ATTR_STATEV_STA )
	ALLExAttrSet(role)
end

---------------------------------------------------�޼����(����+10)---------------------------------------------------------------------------------

function State_GREATSH_Add ( role , statelv )
	local con_dif = 10
	local consb = ConSb( role ) + con_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	ALLExAttrSet(role)
end

function State_GREATSH_Rem ( role , statelv )
	local con_dif = 10
	local consb = ConSb( role ) - con_dif
	SetCharaAttr( consb , role , ATTR_STATEV_CON )
	ALLExAttrSet(role)
end

----------------------------------------------------------�������(����+10)--------------------------------------------------------

function State_MIRAGE_Add ( role , statelv )
	local agi_dif = 10
	local agisb = AgiSb( role ) + agi_dif
	SetCharaAttr( agisb , role , ATTR_STATEV_AGI )
	ALLExAttrSet(role)
end

function State_MIRAGE_Rem ( role , statelv )
	local agi_dif = 10
	local agisb = AgiSb( role ) - agi_dif
	SetCharaAttr( agisb , role , ATTR_STATEV_AGI )
	ALLExAttrSet(role)
end

-----------------------------------------------------------------רע���(רע+10)----------------------------------------------------------------------------

function State_DEVOTE_Add ( role , statelv )
	local dex_dif = 10
	local dexsb = DexSb( role ) + dex_dif
	SetCharaAttr( dexsb , role , ATTR_STATEV_DEX )
	ALLExAttrSet(role)
end

function State_DEVOTE_Rem ( role , statelv )
	local dex_dif = 10
	local dexsb = DexSb( role ) - dex_dif
	SetCharaAttr( dexsb , role , ATTR_STATEV_DEX )
	ALLExAttrSet(role)
end

-------------------------------------------------------�������(����+10)----------------------------------------------------------------------------

function State_VIGOUR_Add ( role , statelv )
	local str_dif = 10
	local strsb = StrSb( role ) + str_dif
	SetCharaAttr( strsb , role , ATTR_STATEV_STR )
	ALLExAttrSet(role)
end

function State_VIGOUR_Rem ( role , statelv )
	local str_dif = 10
	local strsb = StrSb( role ) - str_dif
	SetCharaAttr( strsb , role , ATTR_STATEV_STR )
	ALLExAttrSet(role)
end

---------------------------------------------------------��ֻ������--------------------------------------------------

function State_SHIPDRIVE_Add ( role , statelv )
	local mspdsa_dif = 0
	if statelv == 1 then								
		mspdsa_dif = 1
	end
	local mspdsa = ( MspdSa ( role ) + mspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)
end

function State_SHIPDRIVE_Rem ( role , statelv )
	local mspdsa_dif = 0    
	if statelv == 1 then								
		mspdsa_dif = 1
	end
	local mspdsa = ( MspdSa ( role ) - mspdsa_dif )  * ATTR_RADIX
	SetCharaAttr( mspdsa , role , ATTR_STATEC_MSPD ) 
	ALLExAttrSet(role)
end

-------------------------------------------------��ֻ������----------------------------------------------------

function State_SHIPRECOVER_Add ( role , statelv )
	local defsb_dif = 0
	local defsbk=GetChaAttr(role, ATTR_STATEV_DEF)
	if statelv == 1 then								
		defsb_dif = 300
	end
	local defsb = ( defsbk + defsb_dif )
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 
	ALLExAttrSet(role)
end

function State_SHIPRECOVER_Rem ( role , statelv )
	local defsb_dif = 0
	local defsbk=GetChaAttr(role, ATTR_STATEV_DEF)
	if statelv == 1 then								
		defsb_dif = 300
	end
	local defsb = ( defsbk - defsb_dif )
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 
	ALLExAttrSet(role)
end

------------------------------------------------------------------end----------------------------------------------------------------------------------

------------------1������֤
function SkillCooldown_Daibuzheng1( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_Daibuzheng1_End ( ATKER , DEFER , sklv )
	local atker_name = GetChaDefaultName ( ATKER )
	local defer_name = GetChaDefaultName ( DEFER )
	local NocLock =	KitbagLock( ATKER, 0 )
	local re_type = IsPlayer ( DEFER )
	local State_baitan = GetChaStateLv ( DEFER, STATE_BAT )
	local State_jiaoyi = GetChaStateLv ( DEFER, STATE_JY )
	if re_type == 0 then
		CALCULATE_SKILLEFFECT_LUA_000116 = GetResString("CALCULATE_SKILLEFFECT_LUA_000116")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000116)
		return
	end
	if State_baitan >= 1 then
		CALCULATE_SKILLEFFECT_LUA_000117 = GetResString("CALCULATE_SKILLEFFECT_LUA_000117")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000117)
		return
	end
	if State_jiaoyi >= 1 then
		CALCULATE_SKILLEFFECT_LUA_000118 = GetResString("CALCULATE_SKILLEFFECT_LUA_000118")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000118)
		return
	end
	if atker_name == defer_name then					-------------------kokora080328
		CALCULATE_SKILLEFFECT_LUA_000119 = GetResString("CALCULATE_SKILLEFFECT_LUA_000119")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000119)    
		return
	end
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( ATKER , 5717 ) --����֤
	if item_count <= 0 then  
		
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end
	local statelv_bkdb = GetChaStateLv ( DEFER , STATE_BKDB )		--ȡ���ɴ���״̬�ȼ�
	if statelv_bkdb >=1 then
		
		CALCULATE_SKILLEFFECT_LUA_000120 = GetResString("CALCULATE_SKILLEFFECT_LUA_000120")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000120)
		return
	end
	local Lv_defer = Lv ( DEFER )
	if Lv_defer > 40 then
		
		CALCULATE_SKILLEFFECT_LUA_000121 = GetResString("CALCULATE_SKILLEFFECT_LUA_000121")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000121)
		return
	end		
	local a = DelBagItem ( ATKER , 5717 , 1 ) --ɾ������֤
	local Num_Haorenzheng = CheckBagItem(  DEFER , 5721 ) --����֤
	local Num_Liangminzheng = CheckBagItem(  DEFER , 5722 ) --����֤
	if Num_Haorenzheng >= 1 then
		DelBagItem ( DEFER, 5721, 1) --ɾ������֤
		CALCULATE_SKILLEFFECT_LUA_000122 = GetResString("CALCULATE_SKILLEFFECT_LUA_000122")
		CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
		SystemNotice( DEFER, CALCULATE_EXP_AND_LEVEL_LUA_000040..atker_name..CALCULATE_SKILLEFFECT_LUA_000122)
		CALCULATE_SKILLEFFECT_LUA_000123 = GetResString("CALCULATE_SKILLEFFECT_LUA_000123")
		Notice ( defer_name..CALCULATE_SKILLEFFECT_LUA_000123)
	else
		if Num_Liangminzheng >= 1 then
			DelBagItem ( DEFER, 5722, 1) --ɾ������֤
			CALCULATE_SKILLEFFECT_LUA_000124 = GetResString("CALCULATE_SKILLEFFECT_LUA_000124")
			CALCULATE_SKILLEFFECT_LUA_000125 = GetResString("CALCULATE_SKILLEFFECT_LUA_000125")
			SystemNotice( ATKER, CALCULATE_SKILLEFFECT_LUA_000125..defer_name..CALCULATE_SKILLEFFECT_LUA_000124)
			CALCULATE_SKILLEFFECT_LUA_000124 = GetResString("CALCULATE_SKILLEFFECT_LUA_000124")
			CALCULATE_SKILLEFFECT_LUA_000126 = GetResString("CALCULATE_SKILLEFFECT_LUA_000126")
			Notice ( atker_name..CALCULATE_SKILLEFFECT_LUA_000126..defer_name..CALCULATE_SKILLEFFECT_LUA_000124)
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			SetSpawnPos ( ATKER , BIRTH_BIRTH_CONF_LUA_000052 )
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			MoveCity( ATKER , BIRTH_BIRTH_CONF_LUA_000052)
		else
			CALCULATE_SKILLEFFECT_LUA_000127 = GetResString("CALCULATE_SKILLEFFECT_LUA_000127")
			CALCULATE_SKILLEFFECT_LUA_000128 = GetResString("CALCULATE_SKILLEFFECT_LUA_000128")
			Notice ( defer_name..CALCULATE_SKILLEFFECT_LUA_000128..atker_name..CALCULATE_SKILLEFFECT_LUA_000127)
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			SetSpawnPos ( DEFER , BIRTH_BIRTH_CONF_LUA_000052 )
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			MoveCity( DEFER , BIRTH_BIRTH_CONF_LUA_000052)
		end
	end
end

------------------2������֤
function SkillCooldown_Daibuzheng2( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_Daibuzheng2_End ( ATKER , DEFER , sklv )
	local atker_name = GetChaDefaultName ( ATKER )
	local defer_name = GetChaDefaultName ( DEFER )
	local NocLock =	KitbagLock( ATKER, 0 )
	local re_type = IsPlayer ( DEFER )
	local State_baitan = GetChaStateLv ( DEFER, STATE_BAT )
	local State_jiaoyi = GetChaStateLv ( DEFER, STATE_JY )
	if re_type == 0 then
		CALCULATE_SKILLEFFECT_LUA_000116 = GetResString("CALCULATE_SKILLEFFECT_LUA_000116")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000116)
		return
	end
	if State_baitan >= 1 then
		CALCULATE_SKILLEFFECT_LUA_000117 = GetResString("CALCULATE_SKILLEFFECT_LUA_000117")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000117)
		return
	end
	if State_jiaoyi >= 1 then
		CALCULATE_SKILLEFFECT_LUA_000118 = GetResString("CALCULATE_SKILLEFFECT_LUA_000118")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000118)
		return
	end
	if atker_name == defer_name then					-------------------kokora080328
		CALCULATE_SKILLEFFECT_LUA_000119 = GetResString("CALCULATE_SKILLEFFECT_LUA_000119")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000119)     
		return
	end
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0  
	end
	local item_count = CheckBagItem ( ATKER , 5718 ) --����֤
	if item_count <= 0 then  
		
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end
	local statelv_bkdb = GetChaStateLv ( DEFER , STATE_BKDB )		--ȡ���ɴ���״̬�ȼ�
	if statelv_bkdb >=1 then
		
		CALCULATE_SKILLEFFECT_LUA_000120 = GetResString("CALCULATE_SKILLEFFECT_LUA_000120")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000120)
		return
	end
	local Lv_defer = Lv ( DEFER )
	if Lv_defer > 60 then
		
		CALCULATE_SKILLEFFECT_LUA_000121 = GetResString("CALCULATE_SKILLEFFECT_LUA_000121")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000121)
		return
	end		
	local a = DelBagItem ( ATKER , 5718 , 1 ) --ɾ������֤
	local Num_Haorenzheng = CheckBagItem(  DEFER , 5721 ) --����֤
	local Num_Liangminzheng = CheckBagItem(  DEFER , 5722 ) --����֤
	if Num_Haorenzheng >= 1 then
		DelBagItem ( DEFER, 5721, 1) --ɾ������֤
		CALCULATE_SKILLEFFECT_LUA_000122 = GetResString("CALCULATE_SKILLEFFECT_LUA_000122")
		CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
		SystemNotice( DEFER, CALCULATE_EXP_AND_LEVEL_LUA_000040..atker_name..CALCULATE_SKILLEFFECT_LUA_000122)
		CALCULATE_SKILLEFFECT_LUA_000123 = GetResString("CALCULATE_SKILLEFFECT_LUA_000123")
		Notice ( defer_name..CALCULATE_SKILLEFFECT_LUA_000123)
	else
		if Num_Liangminzheng >= 1 then
			DelBagItem ( DEFER, 5722, 1) --ɾ������֤
			CALCULATE_SKILLEFFECT_LUA_000124 = GetResString("CALCULATE_SKILLEFFECT_LUA_000124")
			CALCULATE_SKILLEFFECT_LUA_000125 = GetResString("CALCULATE_SKILLEFFECT_LUA_000125")
			SystemNotice( ATKER, CALCULATE_SKILLEFFECT_LUA_000125..defer_name..CALCULATE_SKILLEFFECT_LUA_000124)
			CALCULATE_SKILLEFFECT_LUA_000124 = GetResString("CALCULATE_SKILLEFFECT_LUA_000124")
			CALCULATE_SKILLEFFECT_LUA_000126 = GetResString("CALCULATE_SKILLEFFECT_LUA_000126")
			Notice ( atker_name..CALCULATE_SKILLEFFECT_LUA_000126..defer_name..CALCULATE_SKILLEFFECT_LUA_000124)
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			SetSpawnPos ( ATKER , BIRTH_BIRTH_CONF_LUA_000052 )
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			MoveCity( ATKER , BIRTH_BIRTH_CONF_LUA_000052)
		else
			CALCULATE_SKILLEFFECT_LUA_000127 = GetResString("CALCULATE_SKILLEFFECT_LUA_000127")
			CALCULATE_SKILLEFFECT_LUA_000128 = GetResString("CALCULATE_SKILLEFFECT_LUA_000128")
			Notice ( defer_name..CALCULATE_SKILLEFFECT_LUA_000128..atker_name..CALCULATE_SKILLEFFECT_LUA_000127)
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			SetSpawnPos ( DEFER , BIRTH_BIRTH_CONF_LUA_000052 )
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			MoveCity( DEFER , BIRTH_BIRTH_CONF_LUA_000052)
		end
	end
end

------------------3������֤
function SkillCooldown_Daibuzheng3( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_Daibuzheng3_End ( ATKER , DEFER , sklv )
	local atker_name = GetChaDefaultName ( ATKER )
	local defer_name = GetChaDefaultName ( DEFER )
	local NocLock =	KitbagLock( ATKER, 0 )
	local re_type = IsPlayer ( DEFER )
	local State_baitan = GetChaStateLv ( DEFER, STATE_BAT )
	local State_jiaoyi = GetChaStateLv ( DEFER, STATE_JY )
	if re_type == 0 then
		CALCULATE_SKILLEFFECT_LUA_000116 = GetResString("CALCULATE_SKILLEFFECT_LUA_000116")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000116)
		return
	end
	if State_baitan >= 1 then
		CALCULATE_SKILLEFFECT_LUA_000117 = GetResString("CALCULATE_SKILLEFFECT_LUA_000117")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000117)
		return
	end
	if State_jiaoyi >= 1 then
		CALCULATE_SKILLEFFECT_LUA_000118 = GetResString("CALCULATE_SKILLEFFECT_LUA_000118")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000118)
		return
	end
	if atker_name == defer_name then					-------------------kokora080328
		CALCULATE_SKILLEFFECT_LUA_000119 = GetResString("CALCULATE_SKILLEFFECT_LUA_000119")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000119)   
		return
	end
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( ATKER , 5719 ) --����֤
	if item_count <= 0 then  
		
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end
	local statelv_bkdb = GetChaStateLv ( DEFER , STATE_BKDB )		--ȡ���ɴ���״̬�ȼ�
	if statelv_bkdb >=1 then
		
		CALCULATE_SKILLEFFECT_LUA_000120 = GetResString("CALCULATE_SKILLEFFECT_LUA_000120")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000120)
		return
	end
	local Lv_defer = Lv ( DEFER )
	if Lv_defer > 80 then
		
		CALCULATE_SKILLEFFECT_LUA_000121 = GetResString("CALCULATE_SKILLEFFECT_LUA_000121")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000121)
		return
	end		
	local a = DelBagItem ( ATKER , 5719 , 1 ) --ɾ������֤
	local Num_Haorenzheng = CheckBagItem(  DEFER , 5721 ) --����֤
	local Num_Liangminzheng = CheckBagItem(  DEFER , 5722 ) --����֤
	if Num_Haorenzheng >= 1 then
		DelBagItem ( DEFER, 5721, 1) --ɾ������֤
		CALCULATE_SKILLEFFECT_LUA_000122 = GetResString("CALCULATE_SKILLEFFECT_LUA_000122")
		CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
		SystemNotice( DEFER, CALCULATE_EXP_AND_LEVEL_LUA_000040..atker_name..CALCULATE_SKILLEFFECT_LUA_000122)
		CALCULATE_SKILLEFFECT_LUA_000123 = GetResString("CALCULATE_SKILLEFFECT_LUA_000123")
		Notice ( defer_name..CALCULATE_SKILLEFFECT_LUA_000123)
	else
		if Num_Liangminzheng >= 1 then
			DelBagItem ( DEFER, 5722, 1) --ɾ������֤
			CALCULATE_SKILLEFFECT_LUA_000124 = GetResString("CALCULATE_SKILLEFFECT_LUA_000124")
			CALCULATE_SKILLEFFECT_LUA_000125 = GetResString("CALCULATE_SKILLEFFECT_LUA_000125")
			SystemNotice( ATKER, CALCULATE_SKILLEFFECT_LUA_000125..defer_name..CALCULATE_SKILLEFFECT_LUA_000124)
			CALCULATE_SKILLEFFECT_LUA_000124 = GetResString("CALCULATE_SKILLEFFECT_LUA_000124")
			CALCULATE_SKILLEFFECT_LUA_000126 = GetResString("CALCULATE_SKILLEFFECT_LUA_000126")
			Notice ( atker_name..CALCULATE_SKILLEFFECT_LUA_000126..defer_name..CALCULATE_SKILLEFFECT_LUA_000124)
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			SetSpawnPos ( ATKER , BIRTH_BIRTH_CONF_LUA_000052 )
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			MoveCity( ATKER , BIRTH_BIRTH_CONF_LUA_000052)
		else
			CALCULATE_SKILLEFFECT_LUA_000127 = GetResString("CALCULATE_SKILLEFFECT_LUA_000127")
			CALCULATE_SKILLEFFECT_LUA_000128 = GetResString("CALCULATE_SKILLEFFECT_LUA_000128")
			Notice ( defer_name..CALCULATE_SKILLEFFECT_LUA_000128..atker_name..CALCULATE_SKILLEFFECT_LUA_000127)
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			SetSpawnPos ( DEFER , BIRTH_BIRTH_CONF_LUA_000052 )
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			MoveCity( DEFER , BIRTH_BIRTH_CONF_LUA_000052)
		end
	end
end

------------------4������֤
function SkillCooldown_Daibuzheng4( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_Daibuzheng4_End ( ATKER , DEFER , sklv )
	local atker_name = GetChaDefaultName ( ATKER )
	local defer_name = GetChaDefaultName ( DEFER )
	local NocLock =	KitbagLock( ATKER, 0 )
	local re_type = IsPlayer ( DEFER )
	local State_baitan = GetChaStateLv ( DEFER, STATE_BAT )
	local State_jiaoyi = GetChaStateLv ( DEFER, STATE_JY )
	if re_type == 0 then
		CALCULATE_SKILLEFFECT_LUA_000116 = GetResString("CALCULATE_SKILLEFFECT_LUA_000116")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000116)
		return
	end
	if State_baitan >= 1 then
		CALCULATE_SKILLEFFECT_LUA_000117 = GetResString("CALCULATE_SKILLEFFECT_LUA_000117")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000117)
		return
	end
	if State_jiaoyi >= 1 then
		CALCULATE_SKILLEFFECT_LUA_000118 = GetResString("CALCULATE_SKILLEFFECT_LUA_000118")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000118)
		return
	end
	if atker_name == defer_name then					-------------------kokora080328
		CALCULATE_SKILLEFFECT_LUA_000119 = GetResString("CALCULATE_SKILLEFFECT_LUA_000119")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000119)   
		return
	end
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( ATKER , 5720 ) --����֤
	if item_count <= 0 then  
		
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000044 ) 
		return
	end
	local statelv_bkdb = GetChaStateLv ( DEFER , STATE_BKDB )		--ȡ���ɴ���״̬�ȼ�
	if statelv_bkdb >=1 then
		
		CALCULATE_SKILLEFFECT_LUA_000120 = GetResString("CALCULATE_SKILLEFFECT_LUA_000120")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000120)
		return
	end
	local Lv_defer = Lv ( DEFER )
	if Lv_defer > 100 then
		
		CALCULATE_SKILLEFFECT_LUA_000121 = GetResString("CALCULATE_SKILLEFFECT_LUA_000121")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000121)
		return
	end		
	local a = DelBagItem ( ATKER , 5720 , 1 ) --ɾ������֤
	local Num_Haorenzheng = CheckBagItem(  DEFER , 5721 ) --����֤
	local Num_Liangminzheng = CheckBagItem(  DEFER , 5722 ) --����֤
	if Num_Haorenzheng >= 1 then
		DelBagItem ( DEFER, 5721, 1) --ɾ������֤
		CALCULATE_SKILLEFFECT_LUA_000122 = GetResString("CALCULATE_SKILLEFFECT_LUA_000122")
		CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
		SystemNotice( DEFER, CALCULATE_EXP_AND_LEVEL_LUA_000040..atker_name..CALCULATE_SKILLEFFECT_LUA_000122)
		CALCULATE_SKILLEFFECT_LUA_000123 = GetResString("CALCULATE_SKILLEFFECT_LUA_000123")
		Notice ( defer_name..CALCULATE_SKILLEFFECT_LUA_000123)
	else
		if Num_Liangminzheng >= 1 then
			DelBagItem ( DEFER, 5722, 1) --ɾ������֤
			CALCULATE_SKILLEFFECT_LUA_000124 = GetResString("CALCULATE_SKILLEFFECT_LUA_000124")
			CALCULATE_SKILLEFFECT_LUA_000125 = GetResString("CALCULATE_SKILLEFFECT_LUA_000125")
			SystemNotice( ATKER, CALCULATE_SKILLEFFECT_LUA_000125..defer_name..CALCULATE_SKILLEFFECT_LUA_000124)
			CALCULATE_SKILLEFFECT_LUA_000124 = GetResString("CALCULATE_SKILLEFFECT_LUA_000124")
			CALCULATE_SKILLEFFECT_LUA_000126 = GetResString("CALCULATE_SKILLEFFECT_LUA_000126")
			Notice ( atker_name..CALCULATE_SKILLEFFECT_LUA_000126..defer_name..CALCULATE_SKILLEFFECT_LUA_000124)
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			SetSpawnPos ( ATKER , BIRTH_BIRTH_CONF_LUA_000052 )
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			MoveCity( ATKER , BIRTH_BIRTH_CONF_LUA_000052)
		else
			CALCULATE_SKILLEFFECT_LUA_000127 = GetResString("CALCULATE_SKILLEFFECT_LUA_000127")
			CALCULATE_SKILLEFFECT_LUA_000128 = GetResString("CALCULATE_SKILLEFFECT_LUA_000128")
			Notice ( defer_name..CALCULATE_SKILLEFFECT_LUA_000128..atker_name..CALCULATE_SKILLEFFECT_LUA_000127)
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			SetSpawnPos ( DEFER , BIRTH_BIRTH_CONF_LUA_000052 )
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			MoveCity( DEFER , BIRTH_BIRTH_CONF_LUA_000052)
		end
	end
end

----------------------------------------------�ƽ�����
function Skill_HJWL_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( role , 5843 ) --�ƽ�����
	if item_count <= 0 then  
		SkillUnable(role)   
		CALCULATE_SKILLEFFECT_LUA_000044 = GetResString("CALCULATE_SKILLEFFECT_LUA_000044")
		SystemNotice( role , CALCULATE_SKILLEFFECT_LUA_000044 ) 
	end 
	local a = DelBagItem ( role , 5843 , 1 ) 
end 

function Skill_HJWL_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv
	local statetime = 10
	AddState ( ATKER , DEFER , STATE_JLTX4 , statelv , statetime ) 
end 



function STATE_XLTX_Add ( role , statelv)

end
function STATE_XLTX_Rem ( role , statelv)


end

--�����ħ����        by peter 2008.7.1----------------------------------
function State_XTMFS_Add ( role , statelv )
	local str = GetChaAttr( role , ATTR_STA )
		SetCharaAttr(str ,role , ATTR_STATEV_STA)
--	SystemNotice( role ,"ATTR_STATEV_STA�����ħ����")
	ALLExAttrSet(role)
end
function State_XTMFS_Rem ( role , statelv )
	local str = GetChaAttr( role , ATTR_STA )
--	SystemNotice(role , "str=  " ..str )
	local str_add = math.floor(str*0.5)-str
--		SystemNotice( role ,"strstr_add=   " ..str_add )
	SetCharaAttr(0 ,role , ATTR_STATEV_STA)
--		SystemNotice(ATKER,"�����ħ����")
	ALLExAttrSet(role)
end
--�߳���Īа��        by peter 2008.7.1-------------------------------------
function State_MWMXJ_Add ( role , statelv )
	local con = GetChaAttr( role , ATTR_STR ) 
	SetCharaAttr( con , role , ATTR_STATEV_STR )
--		SystemNotice(ATKER,"ATTR_STATEV_STR�߳���Īа��")
	ALLExAttrSet(role)
end
function State_MWMXJ_Rem ( role , statelv )
	SetCharaAttr(0 ,role , ATTR_STATEV_STR)
--			SystemNotice(ATKER,"�߳���Īа��")
	ALLExAttrSet(role)
end

--���Ľ�ն�        by peter 2008.7.1----------------------------------
function State_FFJGD_Add ( role , statelv )
	local MHP = GetChaAttr( role , ATTR_MXHP )
	SetCharaAttr(MHP ,role , ATTR_STATEV_MXHP)
--				SystemNotice(ATKER,"ATTR_STATEV_MXHP���Ľ�ն�")
	ALLExAttrSet(role)
end
function State_FFJGD_Rem ( role , statelv )
	SetCharaAttr(0 ,role , ATTR_STATEV_MXHP)
--					SystemNotice(ATKER,"���Ľ�ն�")
	ALLExAttrSet(role)
end

--Ƥ�ص�����ҩˮ              by peter 2008.7.1-------------------------------------
function State_YSYS_Add ( role , statelv ) 
	local map_name_DEFER = GetChaMapName ( role )
	local agi_atker = Agi(role)
	local Can_Pk_Garner2 = Is_NormalMonster (role)
end
function State_YSYS_Rem ( role , statelv ) 
	local map_name_DEFER = GetChaMapName ( role )
	local agi_atker = Agi(role)
	local Can_Pk_Garner2 = Is_NormalMonster (role)

end 
function State_CD_Add ( role , statelv ) 
	local map_name_DEFER = GetChaMapName ( role )
	local agi_atker = Agi(role)
	local Can_Pk_Garner2 = Is_NormalMonster (role)
end
function State_CD_Rem ( role , statelv ) 
	local map_name_DEFER = GetChaMapName ( role )
	local agi_atker = Agi(role)
	local Can_Pk_Garner2 = Is_NormalMonster (role)

end 

--------------------��˹�Ա�--------------------------------

--function SkillArea_Circle_ZSZB( sklv )							
--	local side = 1000 
--	SetSkillRange ( 10 , side  )  
--end 



--function Skill_ZSZB_Begin ( role , sklv ) 
--end 

--function Skill_ZSZB_End ( ATKER , DEFER , sklv )
--	SystemNotice(ATKER,"�Ա�����")
--		local dmg = math.random ( 10000 , 10000)
--		local statetime = 10
--		Hp_Endure_Dmg ( DEFER , dmg )
--		Hp_Endure_Dmg ( ATKER , dmg )
		--AddState ( ATKER , ATKER , STATE_ZSZB , statelv , statetime )
		--AddState ( ATKER , DEFER , STATE_ZSZB , statelv , statetime )
--end 

--------------------��˹�Ա�--------------------------------

function SkillArea_Circle_ZSZB( sklv )									
	local side = 1000 
	SetSkillRange ( 4, side  )  
end 

function SkillCooldown_ZSZB( sklv )
	local Cooldown = 30000
	return Cooldown
end

---function SkillSp_SSSP ( sklv )										
---	local sp_reduce = 120 + sklv * 20     
---	return sp_reduce 
---end 



function Skill_ZSZB_Begin ( role , sklv ) 
   
end 

function Skill_ZSZB_End ( ATKER , DEFER , sklv )
	local dmg_1 = 10000
	local dmg_2 = 10000
	local reg1 = 0
	reg1 =IsChaInRegion( ATKER, 2 )
	if reg1 == 1 then
		dmg_1 = 10000
	end
	local reg2 = 0
	reg2 =IsChaInRegion( DEFER, 2 )
	if reg2 == 1 then
		dmg_1 =10000
	end
	if is_friend(ATKER, DEFER) == 0 then
	   Hp_Endure_Dmg ( DEFER , dmg_1 ) 
	else
	   Hp_Endure_Dmg ( DEFER , dmg_2 )
	end 

end 

----------------------------------------------------------
--							--
--			�¼���				--
--							--
----------------------------------------------------------


-------��ͼ���ٻ�
 function SkillCooldown_TTzh1( sklv )
	local Cooldown = 3600000
	return Cooldown
end

function SkillArea_Circle_TTZh1( sklv )									
	local side = 1000 
	SetSkillRange ( 4 , side  )  
end

function Skill_TTZh1_End( ATKER , DEFER , sklv )
	local x, y = GetChaPos(ATKER)
		local x1 = x
		local y1 = y + 500
		local new1 = CreateCha(1120, x1, y1, 145, 50)
		SetChaLifeTime(new1, 900000)
		
		
end


-------ʥͼ���ٻ�
 function SkillCooldown_TTzh2( sklv )
	local Cooldown = 3600000
	return Cooldown
end

function SkillArea_Circle_TTZh2( sklv )									
	local side = 1000 
	SetSkillRange ( 4 , side  )  
end

function Skill_TTZh2_End( ATKER , DEFER , sklv )
	local x, y = GetChaPos(ATKER)
		local x2 = x + 500
		local y2 = y - 500
		local new2 = CreateCha(1121, x2, y2, 145, 50)
		SetChaLifeTime(new2, 900000)
		
		
end

	
-----------ͼ�ڱ���

function Skill_TTbw_End ( ATKER , DEFER , sklv ) 
	
	local statelv = sklv 
	local statetime =  10    
	AddState ( ATKER , DEFER , STATE_BIW , statelv , statetime )
end 

--------���ǹ

function Skill_DBQ_End ( ATKER , DEFER , sklv ) 
	local statelv = 10 
	AddState ( ATKER , DEFER , STATE_BDJ , statelv , statetime )
	local hpdmg = 1300 
	Hp_Endure_Dmg ( DEFER , hpdmg )
	
end



--------С��ǹ

function Skill_XBQ_End ( ATKER , DEFER , sklv ) 
	local statelv = 10 
	AddState ( ATKER , DEFER , STATE_BDJ , statelv , statetime )
	local hpdmg = 700 
	Hp_Endure_Dmg ( DEFER , hpdmg )
	
end

-------�������


function Skill_Swjj_End ( ATKER , DEFER , sklv ) 
	
	Hp_Endure_Dmg ( DEFER , dmg )  
	local statelv = sklv 
	local statetime = 3   
	AddState ( ATKER , DEFER , STATE_SWCX , statelv , statetime )
end 

--------���׻�

function Skill_DLJ_End ( ATKER , DEFER , sklv ) 
	local statelv = 10 
	AddState ( ATKER , DEFER , STATE_BDJ , statelv , statetime )
	local hpdmg = 1150 
	Hp_Endure_Dmg ( DEFER , hpdmg )
	
end


--------С�׻�

function Skill_XLJ_End ( ATKER , DEFER , sklv ) 
	local statelv = 10 
	AddState ( ATKER , DEFER , STATE_BDJ , statelv , statetime )
	local hpdmg = 550 
	Hp_Endure_Dmg ( DEFER , hpdmg )
	
end



--------��ħ����

function Skill_EMFR_End ( ATKER , DEFER , sklv ) 
	local statelv = 10 
	AddState ( ATKER , DEFER , STATE_BDJ , statelv , statetime )
	local hpdmg = 1860 
	Hp_Endure_Dmg ( DEFER , hpdmg )
	
end



-------�ػ����ٻ�

function Skill_Shzzh_End( ATKER , DEFER , sklv )
	local x, y = GetChaPos(ATKER)
		local x1 = x
		local x2 = x +600
		local x3 = x -600
		local x4 = x +400
		local y1 = y +600
		local y2 = y -600
		local y3 = y -600
		local y4 = y -400
		local new1 = CreateCha(1122, x1, y1, 145, 50)
		local new2 = CreateCha(1123, x2, y2, 145, 50)
		local new3 = CreateCha(1124, x3, y3, 145, 50)
		local new4 = CreateCha(1125, x4, y4, 145, 50)
		SetChaLifeTime(new1, 900000)
		SetChaLifeTime(new2, 900000)
		SetChaLifeTime(new3, 900000)
		SetChaLifeTime(new4, 900000)
		
		
end


-----�����ػ�����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_Xs( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_Xs_Begin ( role , sklv ) 
	-- local sp = Sp(role) 
	-- local sp_reduce = 7
	-- if sp - sp_reduce < 0 then 
		-- SkillUnable(role)   
		-- return 
	-- end 
	-- Sp_Red (role , sp_reduce ) 
end 

function Skill_Xs_End ( ATKER , DEFER , sklv ) 
	hpdmg = 75	
	Hp_Endure_Dmg ( DEFER , hpdmg )  
	--Notice ( "Xs", "���ּ��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
	Check_Ys_Rem ( ATKER ,DEFER )						--�ж��Ƿ�����
end 


---------------------ռ�����ײ�
function State_BINGGC_Add ( role , sklv ) 
	local statelv = sklv
	local statetime = 5 + sklv * 2 
	local defsb_dif = 5 + statelv * 2 
	local defsb = DefSb(role) + defsb_dif 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 
	ALLExAttrSet(role) 
end 


function State_BINGGC_Rem ( role , statelv ) 
	--LG("state_Bshd" , "function State_Bshd_Rem : " , "role =  " , role , "statelv = " , statelv, "\n" ) 
	local defsb_dif = 5 + statelv * 2 
	local defsb = DefSb(role) - defsb_dif 
	SetCharaAttr( defsb , role , ATTR_STATEV_DEF ) 
	ALLExAttrSet(role)  
end 
---------------��ð������
function State_GANMAO_Add ( role , statelv ) 
	local roleHp=GetChaAttr( role , ATTR_HP )
	if roleHp<5 then
		SetCharaAttr(5, role, ATTR_HP )
	else
		Hp_Endure_Dmg ( role , 1 ) 	
	end
end 

---------------���
function State_CUSI_Rem ( role , sklv )
	SetChaAttr (role , ATTR_HP , 0)
	if sklv~=10 then 
	CALCULATE_SKILLEFFECT_LUA_000129 = GetResString("CALCULATE_SKILLEFFECT_LUA_000129")
	SystemNotice (role,CALCULATE_SKILLEFFECT_LUA_000129)
		GiveItemX(role,0,6375,1,4)
	end
end
function State_LEIPI_Add ( role , sklv ) 								
	if sklv == 2 then
		return
	end
	local role_mxhp = GetChaAttr(role, ATTR_HP)
	Hp_Endure_Dmg ( role , role_mxhp*0.70 )
end 

--------------Ů�����
function STATE_ZBMAXHP_Add ( role ,statelv )
	local MxhpSb_dif = 100000
	local per=GetChaPerHp(role)
	local MxhpSb = MxhpSb( role ) + MxhpSb_dif
	SetCharaAttr( MxhpSb , role , ATTR_STATEV_MXHP )
	ALLExAttrSet(role)
	SetChaPerHp(role,per)
end

function STATE_ZBMAXHP_Rem ( role , statelv )
	local MxhpSb_dif = 100000
	local per=GetChaPerHp(role)
	local MxhpSb = MxhpSb( role ) - MxhpSb_dif
	SetCharaAttr( MxhpSb , role , ATTR_STATEV_MXHP )
	ALLExAttrSet(role)
	SetChaPerHp(role,per)
end

------------------ռ��HP
function STATE_ZBHP_Add (role ,sklv )
	
	local role_mxhp = GetChaAttr (role , ATTR_STATEV_MXHP)
		local per=GetChaPerHp(role)
		role_mxhp = math.floor(sklv*200+ role_mxhp)
	SetCharaAttr( role_mxhp , role , ATTR_STATEV_MXHP )
	ALLExAttrSet(role)
	SetChaPerHp(role,per)
end

function STATE_ZBHP_Rem (role ,sklv )
	local role_mxhp = GetChaAttr (role , ATTR_STATEV_MXHP)
	local per=GetChaPerHp(role)
	role_mxhp = math.floor( role_mxhp-sklv*200)
	SetCharaAttr( role_mxhp , role , ATTR_STATEV_MXHP )
	ALLExAttrSet(role)
	SetChaPerHp(role,per)
end


----------------ռ��SP
function STATE_ZBSP_Add (role ,sklv )
	local role_mxSp = GetChaAttr (role , ATTR_STATEV_MXSP)
		local per=GetChaPerSp(role)
	role_mxSp = math.floor(sklv*100 + role_mxSp)
	SetCharaAttr( role_mxSp , role , ATTR_STATEV_MXSP )
	ALLExAttrSet(role)
	SetChaPerSp(role,per)
end

function STATE_ZBSP_Rem (role ,sklv )
	local role_mxSp = GetChaAttr (role , ATTR_STATEV_MXSP)
	local per=GetChaPerSp(role)
	role_mxSp = math.floor( role_mxSp-sklv*100)
	SetCharaAttr( role_mxSp , role , ATTR_STATEV_MXSP )
	ALLExAttrSet(role)
	SetChaPerSp(role,per)
end


---------------ռ���ƶ��ٶ�
function STATE_ZBMOVE_Add (role ,sklv )
	local role_MOVE = GetChaAttr (role , ATTR_STATEV_MSPD)
	role_MOVE = math.floor(sklv*4.8 + role_MOVE)
	SetCharaAttr( role_MOVE , role , ATTR_STATEV_MSPD )
	ALLExAttrSet(role)
end

function STATE_ZBMOVE_Rem (role ,sklv )
	local role_MOVE = GetChaAttr (role , ATTR_STATEV_MSPD)
	role_MOVE = math.floor( role_MOVE-sklv*4.8)
	SetCharaAttr( role_MOVE , role , ATTR_STATEV_MSPD )
	ALLExAttrSet(role)
end

function State_ShaoKao_Tran (role)
	return 60
end
function State_SBJYGZ_Rem	( role , sklv )
	if sklv==4 then
		AddState ( role , role , STATE_SBJYGZ,6, 1800 )
	end
end 
function Skill_zhanbuwawa_End ( ATKER , DEFER , sklv )
	local atker_name = GetChaDefaultName ( ATKER )
	local defer_name = GetChaDefaultName ( DEFER )
	local NocLock =	KitbagLock( ATKER, 0 )
	local re_type = IsPlayer ( DEFER )
	local State_baitan = GetChaStateLv ( DEFER, STATE_BAT )
	local State_jiaoyi = GetChaStateLv ( DEFER, STATE_JY )
	
	if re_type == 0 then
		CALCULATE_SKILLEFFECT_LUA_000130 = GetResString("CALCULATE_SKILLEFFECT_LUA_000130")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000130)
		return
	end
	if State_baitan >= 1 then
		CALCULATE_SKILLEFFECT_LUA_000131 = GetResString("CALCULATE_SKILLEFFECT_LUA_000131")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000131)
		return
	end
	if State_jiaoyi >= 1 then
		CALCULATE_SKILLEFFECT_LUA_000132 = GetResString("CALCULATE_SKILLEFFECT_LUA_000132")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000132)
		return
	end
	if atker_name == defer_name then					-------------------kokora080328
		CALCULATE_SKILLEFFECT_LUA_000133 = GetResString("CALCULATE_SKILLEFFECT_LUA_000133")
		SystemNotice ( ATKER, CALCULATE_SKILLEFFECT_LUA_000133)    
		return
	end
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000217 = GetResString("CALCULATE_FUNCTIONS_LUA_000217")
		SystemNotice( ATKER , CALCULATE_FUNCTIONS_LUA_000217)
		return 0
	end
	local item_count = CheckBagItem ( ATKER , 6377 )
	if item_count <= 0 then  
		
		CALCULATE_SKILLEFFECT_LUA_000134 = GetResString("CALCULATE_SKILLEFFECT_LUA_000134")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000134 ) 
		return
	end
	local map_name = GetChaMapName ( role )
	if map_name == "starena1" or map_name == "starena2" or map_name == "starena3" or map_name == "garner2" or map_name == "guildwar" or map_name == "guildwar2" then
		CALCULATE_SKILLEFFECT_LUA_000135 = GetResString("CALCULATE_SKILLEFFECT_LUA_000135")
		SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000135 )
		return
	end
	
	local Item=GetChaItem2(ATKER,2,6377)
	local DBtype=0
	local wawaTime=0
	DBtype,wawaTime=GetWaWaAttr(Item)
	local defHp=GetChaAttr(DEFER,ATTR_HP)
	if defHp<1 then 
		CALCULATE_SKILLEFFECT_LUA_000136 = GetResString("CALCULATE_SKILLEFFECT_LUA_000136")
		CALCULATE_SKILLEFFECT_LUA_000137 = GetResString("CALCULATE_SKILLEFFECT_LUA_000137")
		SystemNotice(ATKER,defer_name..CALCULATE_SKILLEFFECT_LUA_000137..defer_name..CALCULATE_SKILLEFFECT_LUA_000136)
		return
	end
	CALCULATE_SKILLEFFECT_LUA_000138 = GetResString("CALCULATE_SKILLEFFECT_LUA_000138")
	SystemNotice(DEFER,atker_name..CALCULATE_SKILLEFFECT_LUA_000138)
	RemoveChaItem(ATKER,6377,1,0,-1,2,1)
	if DBtype==1 then 
		AddState ( ATKER , DEFER , STATE_GANMAO , 1 , 1800 )
		CALCULATE_FUNCTIONS_LUA_000370 = GetResString("CALCULATE_FUNCTIONS_LUA_000370")
		SystemNotice(DEFER,CALCULATE_FUNCTIONS_LUA_000370)
		return
	end	
	if DBtype==2 then 
		CALCULATE_FUNCTIONS_LUA_000371 = GetResString("CALCULATE_FUNCTIONS_LUA_000371")
		SystemNotice(DEFER,CALCULATE_FUNCTIONS_LUA_000371)
			AddState ( ATKER , DEFER , STATE_LST , 1 ,30 )
		return
	end	
	if DBtype==3 then 
		CALCULATE_FUNCTIONS_LUA_000372 = GetResString("CALCULATE_FUNCTIONS_LUA_000372")
		SystemNotice(DEFER,CALCULATE_FUNCTIONS_LUA_000372)
		local statelv = 1
		local statetime = 25
		AddState ( ATKER , DEFER , STATE_XIANRENJIAO , statelv , statetime )
		AddState ( ATKER , DEFER , STATE_XY , statelv , statetime )
		return
	end	
	if DBtype==4 then 
		CALCULATE_FUNCTIONS_LUA_000373 = GetResString("CALCULATE_FUNCTIONS_LUA_000373")
		SystemNotice(DEFER,CALCULATE_FUNCTIONS_LUA_000373)
		local statelv = 1
		local statetime = 20
		AddState ( ATKER , DEFER , STATE_JF , statelv , statetime )
		return
	end	
	if DBtype==5 then 
		CALCULATE_FUNCTIONS_LUA_000374 = GetResString("CALCULATE_FUNCTIONS_LUA_000374")
		SystemNotice(DEFER,CALCULATE_FUNCTIONS_LUA_000374)
		local statelv = 1
		local statetime = 30
		AddState ( ATKER , DEFER , STATE_BIW , statelv , statetime )
		return
	end	
	if DBtype==6 then
		local statelv = 1
		local statetime = 2			
		AddState ( ATKER , DEFER , STATE_LEIPI , statelv , statetime )
		CALCULATE_FUNCTIONS_LUA_000375 = GetResString("CALCULATE_FUNCTIONS_LUA_000375")
		SystemNotice(DEFER,CALCULATE_FUNCTIONS_LUA_000375)
		return
	end	
	if DBtype==7 then 
		AddState ( ATKER , DEFER , STATE_CUSI , 1 , 1 )
		CALCULATE_FUNCTIONS_LUA_000376 = GetResString("CALCULATE_FUNCTIONS_LUA_000376")
		SystemNotice(DEFER,CALCULATE_FUNCTIONS_LUA_000376)
		return
	end	
end 
function Skill_WB_Begin ( atk )
	local Item_Use = GetChaItem ( atk , 1 , 9 )			----ȡ����װ���ĵ���
	if Item_Use == nil then
		CALCULATE_SKILLEFFECT_LUA_000139 = GetResString("CALCULATE_SKILLEFFECT_LUA_000139")
		SystemNotice( atk , CALCULATE_SKILLEFFECT_LUA_000139)
		UseItemFailed ( atk )
		return
	end
	local ItemID_Use = GetItemID ( Item_Use )			----ȡID
	if ItemID_Use ~= 6538 and ItemID_Use~= 6539 and ItemID_Use~= 6585 then
		CALCULATE_SKILLEFFECT_LUA_000139 = GetResString("CALCULATE_SKILLEFFECT_LUA_000139")
		SystemNotice( atk , CALCULATE_SKILLEFFECT_LUA_000139)
		return
	end

	local Item_URE = GetItemAttr ( Item_Use , ITEMATTR_URE )
	if Item_URE == 0 then
		CALCULATE_SKILLEFFECT_LUA_000140 = GetResString("CALCULATE_SKILLEFFECT_LUA_000140")
		SystemNotice ( atk , CALCULATE_SKILLEFFECT_LUA_000140 )
		return
	end
	local JL = CheckJLUre ( atk )
	local lv = GetChaAttr(atk, ATTR_LV)
	local SB = GetChaStateLv ( atk , STATE_SBJYGZ )
	local ChaStateLv = SBStateBS[SB]
	local StateLv = GetChaStateLv ( atk , STATE_ZDSBJYGZ )
	ZDLV = 0 
	if StateLv == 0 then
		ZDLV = 1 
	elseif StateLv == 1 then
		ZDLV = 1.5
	end

	if ItemID_Use == 6538  then
		local lv = Lv ( atk ) 
		if lv > 86 then
			CALCULATE_SKILLEFFECT_LUA_000141 = GetResString("CALCULATE_SKILLEFFECT_LUA_000141")
			SystemNotice ( atk , CALCULATE_SKILLEFFECT_LUA_000141)
			return
		end
		local Item_URE = Item_URE - 5
		SetItemAttr ( Item_Use , ITEMATTR_URE , Item_URE )
		if  JL == 0 then
			GetExpRand ( atk , 0.25 , 1 , 1 )
		elseif JL == 1 then
			GetExpRand ( atk , 0.5 ,1 , 1 )
		end
	elseif ItemID_Use == 6539 then
		local lv = Lv ( atk ) 
		if lv > 86 then
			CALCULATE_SKILLEFFECT_LUA_000141 = GetResString("CALCULATE_SKILLEFFECT_LUA_000141")
			SystemNotice ( atk , CALCULATE_SKILLEFFECT_LUA_000141)
			return
		end
		local Item_URE = Item_URE - 5
		SetItemAttr ( Item_Use , ITEMATTR_URE , Item_URE )
		if  JL == 0 then
			GetExpRand ( atk , 0.75 ,ChaStateLv , ZDLV )
		elseif JL == 1 then
			GetExpRand ( atk , 1 ,ChaStateLv , ZDLV )
		end
	elseif ItemID_Use == 6585 then 
		local Item_URE = Item_URE - 5
		SetItemAttr ( Item_Use , ITEMATTR_URE , Item_URE )
		if  JL == 0 then
			GetExpRand ( atk , 0.75 ,ChaStateLv , ZDLV )
		elseif JL == 1 then
			GetExpRand ( atk , 1 ,ChaStateLv , ZDLV )
		end
	end
end 

function GetExpRand ( role ,value,p1,p2)  ------valueΪ�ӳ�ϵ��,p1Ϊ˫���ľ���ӳ�,p2Ϊ��Ӿ���ӳ�
	local exprandmin = {}
	exprandmin[1] = 1200 
	exprandmin[2] = 2400 
	exprandmin[3] = 4800 
	exprandmin[4] = 5760  
	exprandmin[5] = 6912
	exprandmin[6] = 3456
 
	
	local exprandmax = {}
	exprandmax[1] = 1680
	exprandmax[2] = 4800
	exprandmax[3] = 9600
	exprandmax[4] = 6912
	exprandmax[5] = 8294
	exprandmax[6] = 4147
	
	 local lv = GetChaAttr(role, ATTR_LV)
	-- local SB = GetChaStateLv ( role , STATE_SBJYGZ )
	-- local ChaStateLv = SBStateBS[SB]
	-- local StateLv = GetChaStateLv ( role , STATE_ZDSBJYGZ )
	-- ZDLV = 0 
	-- if StateLv == 0 then
		-- ZDLV = 1 
	-- elseif StateLv == 1 then
		-- ZDLV = 1.5
	-- end
	if lv >= 50 and lv < 60 then
		local add_exp_min = exprandmin[1]*value*p1*p2
		local add_exp_max = exprandmax[1]*value*p1*p2	
		AddExpAll ( role , add_exp_min , add_exp_max, 1 )
	elseif lv >= 60 and lv < 70 then
		local add_exp_min = exprandmin[2]*value*p1*p2
		local add_exp_max = exprandmax[2]*value*p1*p2
		AddExpAll ( role , add_exp_min , add_exp_max, 1 )
	elseif lv >= 70 and lv < 80 then
		local add_exp_min = exprandmin[3]*value*p1*p2
		local add_exp_max = exprandmax[3]*value*p1*p2
		AddExpAll ( role , add_exp_min , add_exp_max, 1 )
	elseif lv >= 80 and lv < 90 then
		local add_exp_min = exprandmin[4]*value*p1*p2
		local add_exp_max = exprandmax[4]*value*p1*p2
		AddExpAll ( role , add_exp_min , add_exp_max, 1 )
	elseif lv >= 90 and lv < 100 then 
		local add_exp_min = exprandmin[5]*value*p1*p2
		local add_exp_max = exprandmax[5]*value*p1*p2
		AddExpAll ( role , add_exp_min , add_exp_max, 1 )
	elseif lv >= 100 then
		local add_exp_min = exprandmin[6]*value*p1*p2
		local add_exp_max = exprandmax[6]*value*p1*p2
		AddExpAll ( role , add_exp_min , add_exp_max, 1 )
	end	
end 

function Skill_WB_End ( role )

end 


function CheckJLUre ( role )
	local Item_bg = GetChaItem ( role , 2 , 1  ) --ȡ��ɫ�����ڶ�����ָ��
	if Item_bg == nil then 
		return 0 
	end
	local Get_Item_Type = GetItemType ( Item_bg )
	if Get_Item_Type ~= 57 and Get_Item_Type ~= 59 then
		return 0
	elseif Get_Item_Type == 57 or Get_Item_Type == 59 then
		local URE = GetItemAttr( Item_bg ,ITEMATTR_URE )
		if URE <= 0 then 
			return 0
		elseif URE > 0 then
			return 1
		end 
	end 
end 
function Skill_YJWB_Begin ( role )
	local el = 0
	el =IsChaInRegion( role, 2 )
	if el == 1 then
		CALCULATE_SKILLEFFECT_LUA_000142 = GetResString("CALCULATE_SKILLEFFECT_LUA_000142")
		SystemNotice( role , CALCULATE_SKILLEFFECT_LUA_000142 )
		UseItemFailed ( role )
		return
	end
	local Item_Use = GetChaItem ( role , 1 , 9 )			----ȡ����װ���ĵ���
	if Item_Use == nil then
		CALCULATE_SKILLEFFECT_LUA_000143 = GetResString("CALCULATE_SKILLEFFECT_LUA_000143")
		SystemNotice( role , CALCULATE_SKILLEFFECT_LUA_000143)
		UseItemFailed ( role )
		return
	end
	local ItemID_Use = GetItemID ( Item_Use )			----ȡID
	if ItemID_Use ~= 6613 then
		CALCULATE_SKILLEFFECT_LUA_000143 = GetResString("CALCULATE_SKILLEFFECT_LUA_000143")
		SystemNotice( role , CALCULATE_SKILLEFFECT_LUA_000143)
		UseItemFailed ( role )
		return
	end
	local item_count = CheckBagItem ( role , 6612 ) 
	if item_count <= 0 then  
		return
	end 
	local Item_URE = GetItemAttr ( Item_Use , ITEMATTR_URE )
	if Item_URE == 0 then
		CALCULATE_SKILLEFFECT_LUA_000144 = GetResString("CALCULATE_SKILLEFFECT_LUA_000144")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000144 )
		return
	end
	if ItemID_Use == 6613 then
		RemoveChaItem( role , 6612 , 1 , 0 , -1 , 2 , 1 )
		ItemUse_YJBT ( role )
	end
end 


function Skill_YJWB_End ( role )
end


function ItemUse_YJBT ( role )
	local charLv = 0
	local exp_now = 0
	local exp_new = 0
	local item_id = 1
	local Item_CanGet = GetChaFreeBagGridNum ( role )	
	if Item_CanGet <= 0 then
		CALCULATE_SKILLEFFECT_LUA_000145 = GetResString("CALCULATE_SKILLEFFECT_LUA_000145")
		SystemNotice( role , CALCULATE_SKILLEFFECT_LUA_000145)
		UseItemFailed ( role )
		return
	end
	local Item_Use = GetChaItem ( role , 1 , 9 )
	local Item_URE = GetItemAttr ( Item_Use , ITEMATTR_URE )
	local Item_URE = Item_URE - 50
	SetItemAttr ( Item_Use , ITEMATTR_URE , Item_URE )

	local getrandom = math.random ( 1 , 1000 )
	if getrandom <= 200 then               ----------------------------------------------------������Ǯ
		local GiveMoney = 50000 * math.random ( 1, 6 )
		CALCULATE_FUNCTIONS_LUA_000095 = GetResString("CALCULATE_FUNCTIONS_LUA_000095")
		CALCULATE_ITEMEFFECT_LUA_000842 = GetResString("CALCULATE_ITEMEFFECT_LUA_000842")
		SystemNotice ( role , CALCULATE_ITEMEFFECT_LUA_000842..GiveMoney..CALCULATE_FUNCTIONS_LUA_000095 )
		AddMoney ( role , 0 , GiveMoney )
		return
	elseif getrandom <= 400 then   
		charLv = Lv ( role )		
		exp_now = GetChaAttr (  role , ATTR_CEXP )----------��ǰ�ȼ�����
		if charLv < 10 then
			exp_new = exp_now + 100
			SetChaAttrI( role , ATTR_CEXP , exp_new )
		elseif charLv < 70 then
			exp_new = math.floor(exp_now + (DEXP[charLv+1] - DEXP[charLv]) * 0.08)
			SetChaAttrI( role , ATTR_CEXP , exp_new )
		elseif charLv < 80 then
			exp_new =  math.floor(exp_now + (DEXP[charLv+1] - DEXP[charLv]) * 0.02)
			SetChaAttrI( role , ATTR_CEXP , exp_new )
		else
			exp_new =  math.floor(exp_now + (DEXP[charLv+1] - DEXP[charLv]) * 0.005)
			SetChaAttrI( role , ATTR_CEXP , exp_new )
		end
		return
	elseif getrandom <= 410 then  
		item_id = 866
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 411 then  
		item_id = 865
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 416 then  
		item_id = 864
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 466 then  
		item_id = 333
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 472 then  
		item_id = 5845
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 478 then  
		item_id = 5846
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 485 then  
		item_id = 5847
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 500 then  
		item_id = 5848
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 510 then  
		item_id = 5849
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 530 then  
		item_id = 2941
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 560 then  
		item_id = 945
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 590 then  
		item_id = 946
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 620 then  
		item_id = 947
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 650 then  
		item_id = 950
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 680 then  
		item_id = 951
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 710 then  
		item_id = 952
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 740 then  
		item_id = 322
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 770 then  
		item_id = 525
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 800 then  
		item_id = 613
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 830 then  
		item_id = 614
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 860 then  
		item_id = 615
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 890 then  
		item_id = 616
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 910 then  
		item_id = 6614
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 940 then  
		item_id = 6615
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	elseif getrandom <= 970 then  
		item_id = 6616
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	else 
		item_id = 6617
		GiveItem ( role , 0 , item_id , 1 , 4 ) 
		local itemname = GetItemName ( item_id ) 
		local cha_name = GetChaDefaultName ( role ) 
		CALCULATE_SKILLEFFECT_LUA_000146 = GetResString("CALCULATE_SKILLEFFECT_LUA_000146")
		local message = cha_name..CALCULATE_SKILLEFFECT_LUA_000146..itemname  
		Notice ( message )
	end
end


function CheckRoleIsInJJCBS ( role ) 
	local posIn = 0
	local teamNum,teamlv = IsPlayerInJJCMap(role)   -- IsPlayerInJJCMap(role) ���жϽ�ɫ�Ƿ��ھ�������ͼ��������򷵻�2�����ִ����ڼ��ž���������������򷵻�0��0
	if teamNum == 1 or teamNum == 3 then
		posIn= CheckPlayerIsInJJC(role,teamNum,teamlv ) -- IsPlayerInJJCMap(role) ���жϽ�ɫ�Ƿ��ھ�������ͼ�ľ���������������򷵻�0�����򷵻�1		
	elseif  teamNum == 2 then 
		local PosX= 0
		local PosY= 0 
		PosX, PosY = GetChaPos(role)
		PosX = math.floor(PosX/100)
		PosY = math.floor(PosY/100)
		if PosX < 55 or PosY < 55 or PosX>71 or PosY>71 then
			posIn = 0
		else
			posIn = 1
		end
	end
	return posIn
end 
--------��֮����״̬
function State_Lbhl_Add ( role , statelv )
	if statelv >=1 and statelv <4 then
		local atksb_dif = 10*statelv
		mnatksb = MnatkSb(role) + atksb_dif  
		mxatksb = MxatkSb(role ) + atksb_dif 
	elseif statelv >=4 and statelv < 7 then
		local atksb_dif = 20*statelv
		mnatksb = MnatkSb(role) + atksb_dif  
		mxatksb = MxatkSb(role ) + atksb_dif 
	elseif statelv >= 7 and statelv <= 10 then
		local atksb_dif = 30*statelv	
		mnatksb = MnatkSb(role) + atksb_dif  
		mxatksb = MxatkSb(role ) + atksb_dif 
	end
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet( role )  
 
end
function State_Lbhl_Rem( role , statelv )
	if statelv >=1 and statelv <4 then
		local atksb_dif = 10*statelv
		mnatksb = MnatkSb(role) - atksb_dif  
		mxatksb = MxatkSb(role ) - atksb_dif 
	elseif statelv >=4 and statelv < 7 then
		local atksb_dif = 20*statelv
		mnatksb = MnatkSb(role) - atksb_dif  
		mxatksb = MxatkSb(role ) - atksb_dif 
	elseif statelv >= 7 and statelv <= 10 then
		local atksb_dif = 30*statelv
		mnatksb = MnatkSb(role) - atksb_dif  
		mxatksb = MxatkSb(role ) - atksb_dif 
	end
	SetCharaAttr( mnatksb , role , ATTR_STATEV_MNATK ) 
	SetCharaAttr( mxatksb , role , ATTR_STATEV_MXATK ) 
	ALLExAttrSet( role )  
end 
--------��֮�龫״̬
function State_Gbhl_Add ( role , statelv )
	if statelv >=1 and statelv <4 then
		Def_dif = DefSb(role) + statelv*5
	elseif statelv >=4 and statelv < 7 then
		Def_dif = DefSb(role) + statelv*10
	elseif statelv >= 7 and statelv <= 10 then
		Def_dif = DefSb(role) + statelv*15
	end
	SetCharaAttr( Def_dif , role , ATTR_STATEV_DEF )
	ALLExAttrSet( role )  
end
function State_Gbhl_Rem( role , statelv )
	if statelv >=1 and statelv <4 then
		Def_dif = DefSb(role) - statelv*5
	elseif statelv >=4 and statelv < 7 then
		Def_dif = DefSb(role) - statelv*10
	elseif statelv >= 7 and statelv <= 10 then
		Def_dif = DefSb(role) - statelv*15
	end
	SetCharaAttr( Def_dif , role , ATTR_STATEV_DEF )
	ALLExAttrSet( role )  
end 
---��֮����״̬
function State_Abhl_Add (role,statelv )
	local pdef = GetChaAttr( role , ATTR_PDEF ) ----ȡ��ɫ�����ֿ�
	if statelv >=1 and statelv <4 then
		Def_dif = DefSb(role) - statelv*5
		Pdef_dif = -6
	elseif statelv >=4 and statelv < 7 then
		Def_dif = DefSb(role) - statelv*10
		Pdef_dif = -18
	elseif statelv >= 7 and statelv <= 10 then
		Def_dif = DefSb(role) - statelv*15
		Pdef_dif = -40
	end
	Pdef_dif2 = Pdef_dif + pdef
	if Pdef_dif2 < 0 then
		Pdef_dif = 0-pdef
	end
	SetCharaAttr( Def_dif , role , ATTR_STATEV_DEF )
	SetCharaAttr(Pdef_dif ,role , ATTR_STATEV_PDEF)
	ALLExAttrSet( role ) 
end 
function State_Abhl_Rem( role , statelv )
	if statelv >=1 and statelv <4 then
		Def_dif = DefSb(role) + statelv*5
	elseif statelv >=4 and statelv < 7 then
		Def_dif = DefSb(role) + statelv*10
	elseif statelv >= 7 and statelv <= 10 then
		Def_dif = DefSb(role) + statelv*15
	end
	SetCharaAttr( Def_dif , role , ATTR_STATEV_DEF )
	SetCharaAttr(0 ,role , ATTR_STATEV_PDEF)
	ALLExAttrSet( role ) 
end 
function CheckAttackState( ATKER , DEFER )
	local Cha_Boat = GetCtrlBoat ( ATKER )
	if Cha_Boat ~=  nil then
		return
	end
	local Item_Bag = GetChaItem(ATKER, 2 , 3 )
	if Item_Bag == nil then
		return
	end
	local Item_ID = GetItemID ( Item_Bag )
	statetime = 30
	local JV = GetPetJV ( ATKER )	
	a = math.random ( 1, 100)
	if JV >= a then
		local statelv = GetPetUre( ATKER )
		if statelv == 3 then
			CALCULATE_SKILLEFFECT_LUA_000147 = GetResString("CALCULATE_SKILLEFFECT_LUA_000147")
			c = CALCULATE_SKILLEFFECT_LUA_000147
		elseif statelv == 6 then
			CALCULATE_SKILLEFFECT_LUA_000148 = GetResString("CALCULATE_SKILLEFFECT_LUA_000148")
			c = CALCULATE_SKILLEFFECT_LUA_000148
		elseif statelv == 10 then
			CALCULATE_SKILLEFFECT_LUA_000149 = GetResString("CALCULATE_SKILLEFFECT_LUA_000149")
			c = CALCULATE_SKILLEFFECT_LUA_000149
		end
		local atk_name = GetChaDefaultName ( ATKER )
		local def_name = GetChaDefaultName ( DEFER )
		local PetLV = GetPetUreLV (ATKER)
		local State_Gbhl = GetChaStateLv ( ATKER, STATE_Gbhl )
		local State_Abhl = GetChaStateLv ( DEFER, STATE_Abhl )
		local State_Lbhl = GetChaStateLv ( ATKER, STATE_Lbhl )
		if Item_ID == 6847 or Item_ID == 6848 or Item_ID == 6849 then
			if State_Gbhl == 0 and State_Lbhl == 0 then
				AddState( ATKER , ATKER , STATE_Gbhl , statelv , statetime )	----��֮��
				TakePetEndure50 (ATKER)
				CALCULATE_SKILLEFFECT_LUA_000150 = GetResString("CALCULATE_SKILLEFFECT_LUA_000150")
				CALCULATE_SKILLEFFECT_LUA_000151 = GetResString("CALCULATE_SKILLEFFECT_LUA_000151")
				SystemNotice (ATKER, CALCULATE_SKILLEFFECT_LUA_000151..c..CALCULATE_SKILLEFFECT_LUA_000150)
				if PetLV == 1 then
					AddState( ATKER , ATKER , STATE_BHLHP , PetLV , 5 )	
				elseif PetLV == 2 then
					AddState( ATKER , ATKER , STATE_BHLHP , PetLV , 10 )	
				elseif PetLV == 3 then
					AddState( ATKER , ATKER , STATE_BHLHP , PetLV , 15 )	
				end
			else
				return
			end
		elseif Item_ID == 6850 or Item_ID == 6851 or Item_ID == 6852 then
			if State_Gbhl == 0 and State_Abhl == 0 and State_Lbhl == 0 then
				AddState( ATKER , DEFER , STATE_Abhl , statelv , statetime )	----��֮��
				AddState( ATKER , ATKER , STATE_BHLHP , 10 , statetime )	
				TakePetEndure50 (ATKER)
				CALCULATE_SKILLEFFECT_LUA_000152 = GetResString("CALCULATE_SKILLEFFECT_LUA_000152")
				CALCULATE_SKILLEFFECT_LUA_000153 = GetResString("CALCULATE_SKILLEFFECT_LUA_000153")
				CALCULATE_SKILLEFFECT_LUA_000154 = GetResString("CALCULATE_SKILLEFFECT_LUA_000154")
				SystemNotice (ATKER, CALCULATE_SKILLEFFECT_LUA_000154..def_name..CALCULATE_SKILLEFFECT_LUA_000153..c..CALCULATE_SKILLEFFECT_LUA_000152)
				CALCULATE_SKILLEFFECT_LUA_000152 = GetResString("CALCULATE_SKILLEFFECT_LUA_000152")
				CALCULATE_SKILLEFFECT_LUA_000155 = GetResString("CALCULATE_SKILLEFFECT_LUA_000155")
				SystemNotice (DEFER, atk_name..CALCULATE_SKILLEFFECT_LUA_000155..c..CALCULATE_SKILLEFFECT_LUA_000152)
				if PetLV == 1 then
					AddState( ATKER , DEFER , STATE_BHLZD , PetLV , 5 )	
				elseif PetLV == 2 then
					AddState( ATKER , DEFER , STATE_BHLZD , PetLV , 10 )	
				elseif PetLV == 3 then
					AddState( ATKER , DEFER , STATE_BHLZD , PetLV , 15 )	
				end
			else
				return
			end
		elseif Item_ID == 6853 or Item_ID == 6854 or Item_ID == 6855 then
			if State_Gbhl == 0 and State_Lbhl == 0 then
				AddState( ATKER , ATKER , STATE_Lbhl , statelv , statetime )	----��֮��
				TakePetEndure50 (ATKER)
				CALCULATE_SKILLEFFECT_LUA_000156 = GetResString("CALCULATE_SKILLEFFECT_LUA_000156")
				CALCULATE_SKILLEFFECT_LUA_000157 = GetResString("CALCULATE_SKILLEFFECT_LUA_000157")
				SystemNotice (ATKER, CALCULATE_SKILLEFFECT_LUA_000157..c..CALCULATE_SKILLEFFECT_LUA_000156)
				if PetLV == 1 then
					AddState( ATKER , DEFER , STATE_BHLXY , PetLV , 1 )	
				elseif PetLV == 2 then
					AddState( ATKER , DEFER , STATE_BHLXY , PetLV , 2 )	
				elseif PetLV == 3 then
					AddState( ATKER , DEFER , STATE_BHLXY , PetLV , 3 )	
				end
				HP_BHLXY(ATKER,DEFER,PetLV) 
			else
				return
			end
		else
			return 
		end
	else
		return
	end
end 
function CheckAttackState1( ATKER , DEFER )
	local Cha_Boat = GetCtrlBoat ( ATKER )
	if Cha_Boat ~=  nil then
		return
	end
	local Item_Bag = GetChaItem(ATKER, 2 , 3 )
	if Item_Bag == nil then
		return
	end
	local Item_ID = GetItemID ( Item_Bag )
	statetime = 30
	local JV = GetPetJV ( ATKER )	
	a = math.random ( 1, 100)
	if JV >= a then
		local statelv = GetPetUre( ATKER )
		if statelv == 3 then
			CALCULATE_SKILLEFFECT_LUA_000147 = GetResString("CALCULATE_SKILLEFFECT_LUA_000147")
			c = CALCULATE_SKILLEFFECT_LUA_000147
		elseif statelv == 6 then
			CALCULATE_SKILLEFFECT_LUA_000148 = GetResString("CALCULATE_SKILLEFFECT_LUA_000148")
			c = CALCULATE_SKILLEFFECT_LUA_000148
		elseif statelv == 10 then
			CALCULATE_SKILLEFFECT_LUA_000149 = GetResString("CALCULATE_SKILLEFFECT_LUA_000149")
			c = CALCULATE_SKILLEFFECT_LUA_000149
		end
		local atk_name = GetChaDefaultName ( ATKER )
		local def_name = GetChaDefaultName ( DEFER )
		local PetLV = GetPetUreLV (ATKER)
		local State_Gbhl = GetChaStateLv ( ATKER, STATE_Gbhl )
		local State_Abhl = GetChaStateLv ( DEFER, STATE_Abhl )
		local State_Lbhl = GetChaStateLv ( ATKER, STATE_Lbhl )
		if Item_ID == 6847 or Item_ID == 6848 or Item_ID == 6849 then
			if State_Gbhl == 0 and State_Lbhl == 0 then
				AddState( ATKER , ATKER , STATE_Gbhl , statelv , statetime )	----��֮��
				TakePetEndure50 (ATKER)
				CALCULATE_SKILLEFFECT_LUA_000150 = GetResString("CALCULATE_SKILLEFFECT_LUA_000150")
				CALCULATE_SKILLEFFECT_LUA_000151 = GetResString("CALCULATE_SKILLEFFECT_LUA_000151")
				SystemNotice (ATKER, CALCULATE_SKILLEFFECT_LUA_000151..c..CALCULATE_SKILLEFFECT_LUA_000150)
				if PetLV == 1 then
					AddState( ATKER , ATKER , STATE_BHLHP , PetLV , 5 )	
				elseif PetLV == 2 then
					AddState( ATKER , ATKER , STATE_BHLHP , PetLV , 10 )	
				elseif PetLV == 3 then
					AddState( ATKER , ATKER , STATE_BHLHP , PetLV , 15 )	
				end
			else
				return
			end
		elseif Item_ID == 6853 or Item_ID == 6854 or Item_ID == 6855 then
			if State_Gbhl == 0 and State_Lbhl == 0 then
				AddState( ATKER , ATKER , STATE_Lbhl , statelv , statetime )	----��֮��
				TakePetEndure50 (ATKER)
				CALCULATE_SKILLEFFECT_LUA_000156 = GetResString("CALCULATE_SKILLEFFECT_LUA_000156")
				CALCULATE_SKILLEFFECT_LUA_000157 = GetResString("CALCULATE_SKILLEFFECT_LUA_000157")
				SystemNotice (ATKER, CALCULATE_SKILLEFFECT_LUA_000157..c..CALCULATE_SKILLEFFECT_LUA_000156)
			else
				return
			end
		else
			return 
		end
	else
		return
	end
end 
function GetPetUre( role )		----- �����;þ���״̬�ȼ�
	local Item_Bag = GetChaItem( role, 2 , 3 )
	local Item_type = GetItemType(Item_Bag)
	if Item_type == 77 then
		local Item_ID = GetItemID ( Item_Bag )
		statelv = 0
		if Item_ID == 6847 or Item_ID == 6850 or Item_ID == 6853 then
				statelv = 3
		elseif Item_ID == 6848 or Item_ID == 6851 or Item_ID == 6854 then
				statelv = 6
		elseif Item_ID == 6849 or Item_ID == 6852 or Item_ID == 6855 then
				statelv = 10
		end
	else
		statelv = 0
	end
	return statelv
end 
function GetPetUreLV( role )		----- �����;þ���״̬�ȼ�
	local Item_Bag = GetChaItem( role, 2 , 3 )
	local Item_type = GetItemType(Item_Bag)
	if Item_type == 77 then
		local Item_ID = GetItemID ( Item_Bag )
		statelv = 0
		if Item_ID == 6847 or Item_ID == 6850 or Item_ID == 6853 then
				statelv = 1
		elseif Item_ID == 6848 or Item_ID == 6851 or Item_ID == 6854 then
				statelv = 2
		elseif Item_ID == 6849 or Item_ID == 6852 or Item_ID == 6855 then
				statelv = 3
		end
	else
		statelv = 0
	end
	return statelv
end 


function GetPetJV ( ATKER)
	JV = 0
	local PetLv = GetPetUreLV (ATKER)
	JV = 2*PetLv*10
	return JV 
end 
function GivePetState( ATKER , DEFER )
	local PetLv = GetPetUreLV (ATKER)
	local State_Lbhl = GetChaStateLv ( ATKER, STATE_Lbhl )
	if State_Lbhl >= 1 then
		AddState( ATKER , DEFER , STATE_LEIPI , 2 , 2 )	
	end
end 


function State_BHLHP_Add ( role , statelv ) 
	if statelv <= 3 then
	local sta = GetChaAttr ( role , ATTR_STA )
	if statelv == 1 then
		hp = math.floor (sta*statelv/5*10)
	elseif statelv == 2 then
		hp = math.floor (sta*statelv/10*10)
		elseif statelv == 3 then
			hp = math.floor (sta*statelv/15*10)
		end
		local hp_now = GetChaAttr( role , ATTR_HP )
		local  hp_now = hp_now + hp
		SetCharaAttr(hp_now, role, ATTR_HP)
	else
	end
end 


function State_BHLZD_Add ( role , statelv )
	local hp_now = GetChaAttr( role , ATTR_MXHP )
	local sta = GetChaAttr ( role , ATTR_STA )
	Skill_time = 5
	if statelv == 1 then
		skltime = Skill_time*1
		dmg = math.floor ((hp_now*0.1*statelv + hp_now*0.01*100/sta*statelv)/skltime)
	elseif statelv == 2 then
		skltime = Skill_time*2
		dmg = math.floor ((hp_now*0.1*statelv + hp_now*0.01*100/sta*statelv)/skltime)
	elseif statelv == 3 then
		skltime = Skill_time*3
		dmg = math.floor ((hp_now*0.1*statelv + hp_now*0.01*100/sta*statelv)/skltime)
	end
	if dmg > 1000 then
		dmg = 1000
	end
-----�˺����50%����	
	all_dmg = dmg*skltime
	MAX_HP = hp_now/2
	if all_dmg > MAX_HP then
		all_dmg = MAX_HP
	end
	dmg = math.floor ( all_dmg/skltime )
	Hp_Dmg ( role , dmg )  
end 


function State_BHLXY_Add ( role , statelv )

end 

function HP_BHLXY ( ATKER , DEFER ,statelv)
	local 	sta = GetChaAttr (ATKER , ATTR_STA ) 
	dmg = sta * statelv
	Hp_Dmg ( DEFER , dmg )  
end 
--�Ͷ������Ϳ��\�Ͷ��ڻ���--20090421bylochbai
function Skill_XunBao_Begin ( role )
	local el = 0
	el =IsChaInRegion( role, 2 )
	if el == 1 then
		CALCULATE_SKILLEFFECT_LUA_000158 = GetResString("CALCULATE_SKILLEFFECT_LUA_000158")
		SystemNotice( role , CALCULATE_SKILLEFFECT_LUA_000158 )
		UseItemFailed ( role )
		return
	end
	local Item_Use = GetChaItem ( role , 1 , 9 )			----ȡ����װ���ĵ���
	if Item_Use == nil then
		CALCULATE_SKILLEFFECT_LUA_000159 = GetResString("CALCULATE_SKILLEFFECT_LUA_000159")
		SystemNotice( role , CALCULATE_SKILLEFFECT_LUA_000159)
		UseItemFailed ( role )
		return
	end
	local ItemID_Use = GetItemID ( Item_Use )			----ȡID
	if ItemID_Use ~= 6917 and ItemID_Use ~= 6944 then
		CALCULATE_SKILLEFFECT_LUA_000159 = GetResString("CALCULATE_SKILLEFFECT_LUA_000159")
		SystemNotice( role , CALCULATE_SKILLEFFECT_LUA_000159)
		UseItemFailed ( role )
		return
	end
	
	local Item_URE = GetItemAttr ( Item_Use , ITEMATTR_URE )
	if Item_URE <= 0 then
		CALCULATE_SKILLEFFECT_LUA_000140 = GetResString("CALCULATE_SKILLEFFECT_LUA_000140")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000140 )
		UseItemFailed ( role )
		return
	end
	if ItemID_Use == 6917 then
		ItemUse_WYQLKG ( role )
	elseif ItemID_Use == 6944 then
		ItemUse_WYHDKG ( role )
	end
end 


function Skill_XunBao_End ( role )
end


function ItemUse_WYQLKG ( role )	-----------------------------�Ͷ������Ϳ��
	local Item_CanGet = GetChaFreeBagGridNum ( role )	--------------------------------�жϱ���������
	if Item_CanGet <= 0 then
		CALCULATE_SKILLEFFECT_LUA_000160 = GetResString("CALCULATE_SKILLEFFECT_LUA_000160")
		SystemNotice( role , CALCULATE_SKILLEFFECT_LUA_000160)
		UseItemFailed ( role )
		return
	end
	
	local Item_Use = GetChaItem ( role , 1 , 9 )	----------------------------------�۳��;�
	local Item_URE = GetItemAttr ( Item_Use , ITEMATTR_URE )
	local Item_URE = Item_URE - 5
	SetItemAttr ( Item_Use , ITEMATTR_URE , Item_URE )
	
	if math.mod ( Item_URE , 2000 ) == 0 and Item_URE > 0 and Item_URE < 30000 then
		GiveItem ( role , 0 , 6900 , 1 , 4 ) 
		CALCULATE_SKILLEFFECT_LUA_000161 = GetResString("CALCULATE_SKILLEFFECT_LUA_000161")
		SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000161 )
	end
	if math.mod ( Item_URE , 100 ) == 0 and Item_URE > 0 and math.mod ( Item_URE , 2000 ) ~= 0 then	
		local getrandom = math.random ( 1 , 1000 )
		if getrandom <= 200 then               ----------------------------------------------------20%Ϊ����
			GiveItem ( role , 0 , 6203 , 1 , 4 ) 
			CALCULATE_SKILLEFFECT_LUA_000162 = GetResString("CALCULATE_SKILLEFFECT_LUA_000162")
			SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000162 )
		elseif getrandom > 200 and getrandom <= 400 then  ----------------------------------20%Ϊ����  
			GiveItem ( role , 0 , 1849 , 1 , 4 ) 
			CALCULATE_SKILLEFFECT_LUA_000163 = GetResString("CALCULATE_SKILLEFFECT_LUA_000163")
			SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000163 )
		elseif getrandom > 400 and getrandom <= 700 then 	----------------------------------30%Ϊ���   
			GiveItem ( role , 0 , 1848 , 1 , 4 ) 
			CALCULATE_SKILLEFFECT_LUA_000164 = GetResString("CALCULATE_SKILLEFFECT_LUA_000164")
			SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000164 )
		elseif getrandom > 700 and getrandom <= 999 then ----------------------------------30%Ϊƻ�� 
			GiveItem ( role , 0 , 1847 , 1 , 4 ) 
			CALCULATE_SKILLEFFECT_LUA_000165 = GetResString("CALCULATE_SKILLEFFECT_LUA_000165")
			SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000165 )
		elseif getrandom > 999 and getrandom <= 1000 then  -----------------------------------0.1%Ϊ���ͼ�����
			GiveItem ( role , 0 , 6931 , 1 , 4 ) 
			CALCULATE_SKILLEFFECT_LUA_000166 = GetResString("CALCULATE_SKILLEFFECT_LUA_000166")
			SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000166 )
		end
	end
end


function ItemUse_WYHDKG ( role )	-------------------------�Ͷ��ڻ���
	local Item_CanGet = GetChaFreeBagGridNum ( role )	--------------------------------�жϱ���������
	if Item_CanGet <= 0 then
		CALCULATE_SKILLEFFECT_LUA_000160 = GetResString("CALCULATE_SKILLEFFECT_LUA_000160")
		SystemNotice( role , CALCULATE_SKILLEFFECT_LUA_000160)
		UseItemFailed ( role )
		return
	end
	
	local Item_Use = GetChaItem ( role , 1 , 9 )	----------------------------------�۳��;�
	local Item_URE = GetItemAttr ( Item_Use , ITEMATTR_URE )
	local Item_URE = Item_URE - 5
	SetItemAttr ( Item_Use , ITEMATTR_URE , Item_URE )
	
	if Item_URE == 1500 then
	GiveItem ( role , 0 , 6900 , 1 , 4 ) 
	CALCULATE_SKILLEFFECT_LUA_000161 = GetResString("CALCULATE_SKILLEFFECT_LUA_000161")
	SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000161 )
	end
	if math.mod ( Item_URE , 100 ) == 0 and Item_URE > 0 and Item_URE ~= 1500 then	
		local getrandom = math.random ( 1 , 1000 )
		if getrandom <= 200 then               ----------------------------------------------------20%Ϊ����
			GiveItem ( role , 0 , 6203 , 1 , 4 ) 
			CALCULATE_SKILLEFFECT_LUA_000162 = GetResString("CALCULATE_SKILLEFFECT_LUA_000162")
			SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000162 )
		elseif getrandom > 200 and getrandom <= 400 then	----------------------------------20%Ϊ����  
			GiveItem ( role , 0 , 1849 , 1 , 4 ) 
			CALCULATE_SKILLEFFECT_LUA_000163 = GetResString("CALCULATE_SKILLEFFECT_LUA_000163")
			SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000163 )
		elseif getrandom > 400 and getrandom <= 700 then	----------------------------------30%Ϊ���   
			GiveItem ( role , 0 , 1848 , 1 , 4 ) 
			CALCULATE_SKILLEFFECT_LUA_000164 = GetResString("CALCULATE_SKILLEFFECT_LUA_000164")
			SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000164 )
		elseif getrandom > 700 and getrandom <= 999 then	----------------------------------30%Ϊƻ��
			GiveItem ( role , 0 , 1847 , 1 , 4 ) 
			CALCULATE_SKILLEFFECT_LUA_000165 = GetResString("CALCULATE_SKILLEFFECT_LUA_000165")
			SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000165 )
		elseif getrandom > 999 and getrandom <= 1000 then  -----------------------------------0.1%Ϊ���ͼ�����
			GiveItem ( role , 0 , 6931 , 1 , 4 ) 
			CALCULATE_SKILLEFFECT_LUA_000166 = GetResString("CALCULATE_SKILLEFFECT_LUA_000166")
			SystemNotice ( role , CALCULATE_SKILLEFFECT_LUA_000166 )
		end
	end
end
function TakePetEndure50 (role)
	local Item = GetChaItem ( role , 2 , 3 )
	local Item_type = GetItemType(Item)
	local Item_ID = GetItemID ( Item )
	if Item_type == 77 then
		local Item_ure = GetItemAttr( Item ,ITEMATTR_URE )       --����
		if Item_ure > 25 then
			Num = Item_ure - 25
			SetItemAttr ( Item , ITEMATTR_URE , Num )
		elseif Item_ure <= 25 then
			local ItemName = GetItemName ( Item_ID ) 
			RemoveChaItem( role , Item_ID , 0 , 2 , 3 , 2 , 1 )	
			CALCULATE_FUNCTIONS_LUA_000722 = GetResString("CALCULATE_FUNCTIONS_LUA_000722")
			SystemNotice (role,ItemName..CALCULATE_FUNCTIONS_LUA_000722)	
		end
	else
		return
	end
end 
function SkillSp_XLZD ( sklv )										
	local sp_reduce = 100 
	return sp_reduce 
end 

function Skill_XLZD_End (ATKER , DEFER , sklv )
	local hp_defer = Hp ( DEFER ) 
	if hp_defer >= 100000 then 
		local a = Percentage_Random (0.8)
		if a == 1 then
			statetime = 5 + math.floor ( sklv * 0.3 ) 
		else
			SetSus( DEFER , 0 ) 
			CALCULATE_SKILLEFFECT_LUA_000167 = GetResString("CALCULATE_SKILLEFFECT_LUA_000167")
			SystemNotice ( ATKER , CALCULATE_SKILLEFFECT_LUA_000167) 
			return
		end
	end 

	if GetChaAIType( DEFER ) >= 21 then    --21����ΪBossAI�������Boss����boss��ͬ���趨���Ա���״̬�Ĵ���
		if BOSSXZSJ[GetChaTypeID( DEFER )] == 0 then
			CALCULATE_SKILLEFFECT_LUA_000028 = GetResString("CALCULATE_SKILLEFFECT_LUA_000028")
			Notice (CALCULATE_SKILLEFFECT_LUA_000028)
			return
		else
			BOSSXZSJ[GetChaTypeID( DEFER )] = BOSSXZSJ[GetChaTypeID( DEFER )] -1
		end
	end
	local statetime = 9
	AddState( ATKER , DEFER , STATE_XLZD , 1 , statetime )
end

function SkillCooldown_XLZD (sklv)
	local Cooldown = 30000
	return Cooldown
end 



function New_Xlcz ( ATKER , DEFER) 
	local lv_atker = Lv ( TurnToCha ( ATKER ) ) 
	local lv_defer = Lv ( TurnToCha ( DEFER ) ) 
	local sta_atker = Sta(ATKER) 
	local sta_defer = Sta(DEFER) 
	local lv_dif = math.max(1,lv_atker-lv_defer)
	local sta_dif = math.max(1,math.floor ((sta_atker-sta_defer)/5))
	local dif = math.min (lv_dif+sta_dif,20)
	return dif
end 


function State_TK_Add (role , statelv) 
	hpdmg = math.floor (statelv *100/5 )
	Hp_Endure_Dmg ( role, hpdmg )  
end 


function State_XX_Add ( role, statelv )

end 

function STATE_HFHP_Add ( role, statelv )
	hp = math.floor(statelv*100/10/2)
	local hp_now = GetChaAttr( role , ATTR_HP )
	local  hp_now = hp_now + hp
	SetCharaAttr(hp_now, role, ATTR_HP)
end 


function State_XLZD_Add ( role, statelv )
	AddState( role, role , STATE_XY , 10 , 2 ) 	
end 


function SkillCooldown_shenmixueqiu( sklv )
	local Cooldown = 3000
	return Cooldown
end

function Skill_shenmixueqiu_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		SystemNotice( role , "The inventory is locked.")
		return 0
	end
	local atk_role = TurnToCha ( role ) 
	local item_count = CheckBagItem ( atk_role , 7713 ) --��ֻ������1
	if item_count <= 0 then  
		SkillUnable(atk_role)   
		SystemNotice ( atk_role , "There is no required item to use the skill." ) 
	end 
	local a = DelBagItem ( atk_role , 7713 , 1 ) 
end


function Skill_shenmixueqiu_End ( ATKER , DEFER , sklv ) 
	local NocLock =	KitbagLock( ATKER, 0 )
	if NocLock == LUA_FALSE then
		SystemNotice( ATKER , "The inventory is locked.")
		return 0
	end	
	local dmg = 2500
	Hp_Endure_Dmg ( DEFER , dmg) 
	Check_Ys_Rem ( ATKER , DEFER )						--�ж��Ƿ����� 
end

-----����ն����������������������������������������������������������������������������������������������������������������������������������������������������

function SkillCooldown_FNZ( sklv )
	local Cooldown = 5000
	return Cooldown
end

function Skill_FNZ_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		SystemNotice( role , "Inventory locked")
		return 0
	end
	local item_count = CheckBagItem ( role , 7518 ) --F�������Ϳ�е
	if item_count <= 0 then  
		SkillUnable(role)   
		SystemNotice ( role , "There is no card in inventory to activate" ) 
	end 
	local item_count = CheckBagItem ( role , 7519 ) --F��������
	if item_count <= 1 then  
		SkillUnable(role)   
		SystemNotice ( role , "There is not enough card to use the skill" ) 
	end 
	local a = DelBagItem ( role , 7519 , 2 ) 
end 

function Skill_FNZ_End ( ATKER , DEFER , sklv ) 
	hpdmg = 3000	
	Hp_Endure_Dmg ( DEFER , hpdmg )  
	--Notice ( "Xs", "���ּ��ܵȼ� = " , sklv , "�����˺� = " , dmg , '\n" ) 
	Check_Ys_Rem ( ATKER ,DEFER )						--�ж��Ƿ�����
end 
--��������������������������������������������������������������������������������������������������������������������������������������������������������������������

function SkillSp_HW ( sklv ) 
	local sp_reduce = 0  
	return sp_reduce 
end 

function SkillCooldown_HW( sklv ) 
	local Cooldown = 30000 
	return Cooldown 
end 

function Skill_HW_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		SystemNotice( role , "Inventory locked")
		return 0
	end
	local item_count = CheckBagItem ( role , 7518 ) --F�������Ϳ�е
	if item_count <= 0 then  
		SkillUnable(role)   
		SystemNotice ( role , "There is no card in inventory to activate" ) 
	end 
	local item_count = CheckBagItem ( role , 7519 ) --F��������
	if item_count <= 1 then  
		SkillUnable(role)   
		SystemNotice ( role , "There is not enough card to use the skill" ) 
	end 
	local a = DelBagItem ( role , 7519 , 2 ) 
end 

function Skill_HW_End ( ATKER , DEFER , sklv ) 
	--LG( "skill_ys", "enter function Skill_Def_Ys : " , "\n" ) 
	local statelv = sklv 
	local statetime = 20 + sklv * 10
	local map_name_ATKER = GetChaMapName ( ATKER )
	local map_name_DEFER = GetChaMapName ( DEFER )
	local agi_atker = Agi(ATKER)
	local Can_Pk_Garner2 = Is_NormalMonster (DEFER)
	if map_name_ATKER == "garner2" or map_name_DEFER == "garner2" or map_name_ATKER == "starena1" or map_name_DEFER == "starena1"or map_name_ATKER == "starena2" or map_name_DEFER == "starena2" or map_name_ATKER == "starena3" or map_name_DEFER == "starena3"then
		if Can_Pk_Garner2 == 0 then
			statetime = 20 + agi_atker/4 + sklv*5
	--		Notice ( "statetime="..statetime)
		end
	end
	AddState ( ATKER , DEFER , STATE_YS , statelv , statetime ) 
	
	--LG("skill_ys", "function Skill_Def_Ys : " , "role = " , role , "sklv =  " , sklv , "\n" ) 
-----������״̬
	CheckAttackState1( ATKER , DEFER )
end 





--�����ܡ���������������������������������������������������������������������������������������������������������������������������������������
function SkillSp_NLD ( sklv )										
	local sp_reduce = 0  
	return sp_reduce 
end

function SkillCooldown_NLD( sklv )
	local Cooldown = 1000
	return Cooldown
end

function Skill_NLD_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		SystemNotice( role , "Inventory locked")
		return 0
	end
	local item_count = CheckBagItem ( role , 7518 ) --F�������Ϳ�е
	if item_count <= 0 then  
		SkillUnable(role)   
		SystemNotice ( role , "There is no card in inventory to activate" ) 
	end 
	local item_count = CheckBagItem ( role , 7519 ) --F��������
	if item_count <= 2 then  
		SkillUnable(role)   
		SystemNotice ( role , "There is not enough card to use the skill" ) 
	end 
	local a = DelBagItem ( role , 7519 , 3 ) 
end 
function Skill_NLD_End ( ATKER , DEFER , sklv )  
	local statelv = sklv 
	local statetime = -1  
	----bossʹ�ü��ܴ���
	if GetChaTypeID( ATKER ) == 984 then
		statelv = 10
	end
	----bossʹ�ü��ܴ�������
        AddState( ATKER , DEFER , STATE_MFD, statelv , statetime )
	--LG("skill_Xlpz", "function Skill_Oper_Xlpz: " , "add state xlpz " , "\n" ) 
---------------������״̬
	CheckAttackState1( ATKER , DEFER )		
		
end 

-------------------------------------����������-----------------------------------------------------------------------

function SkillSp_NLSFW ( sklv )										--����"�����Ȼ�"��sp���Ĺ�ʽ
	local sp_reduce = 50 + sklv * 2   
	return sp_reduce 
end 

function SkillCooldown_NLSFW( sklv ) 
	local Cooldown = 2000
	return Cooldown
end

function Skill_NLSFW_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		SystemNotice( role , "Inventory locked")
		return 0
	end
	local item_count = CheckBagItem ( role , 7518 ) --F�������Ϳ�е
	if item_count <= 0 then  
		SkillUnable(role)   
		SystemNotice ( role , "There is no card in inventory to activate" ) 
	end 
	local item_count = CheckBagItem ( role , 7519 ) --F��������
	if item_count <= 4 then  
		SkillUnable(role)   
		SystemNotice ( role , "There is not enough card to use the skill" ) 
	end 
	local a = DelBagItem ( role , 7519 , 5 ) 
end 

function Skill_NLSFW_End ( ATKER , DEFER , sklv ) 
	local statelv = sklv 
	local statetime = 15 
	local StateLv = GetChaStateLv ( DEFER , STATE_TTISW )
	if StateLv ~= 3 then
		AddState ( ATKER , DEFER , STATE_CRXSF , statelv , statetime ) 
	end

	Check_Ys_Rem ( ATKER , DEFER )					--�ж��Ƿ�����
end 

function State_CRXSF_Add ( role , statelv ) 

end 

function State_CRXSF_Rem ( role , statelv ) 

end


---------ʥ�����--------------------------------------------------------------------------
function Skill_MLCJ_Begin ( role , sklv ) 
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		SystemNotice( role , "Inventory locked")
		return 0
	end
	local item_count = CheckBagItem ( role , 7518 ) --F�������Ϳ�е
	if item_count <= 0 then  
		SkillUnable(role)   
		SystemNotice ( role , "There is no card in inventory to activate" ) 
	end 
	local item_count = CheckBagItem ( role , 7519 ) --F��������
	if item_count <= 9 then  
		SkillUnable(role)   
		SystemNotice ( role , "There is not enough card to use the skill" ) 
	end 
	local a = DelBagItem ( role , 7519 , 10 ) 
end 
function Skill_MLCJ_End ( ATKER , DEFER , sklv ) 
	
	local hpdmg = -10000
	Hp_Endure_Dmg ( DEFER , hpdmg ) 

end 

--Force of the Demon
function State_EMZL_Add(role,statelv)
	local mxhpsb_dif = 1000
	local mxhpsb = MxhpSb(role) + mxhpsb_dif
	local mxspsb_dif = 1000
	local mxspsb = MxspSb(role) + mxspsb_dif
	local mnatksb_dif = 250
	local mnatksb = MnatkSb(role) + mnatksb_dif
	local mxatksb_dif = 250
	local mxatksb = MxatkSb(role) + mxatksb_dif
	local mspdsa_dif = 0.5
	local mspdsa = math.floor ( (MspdSa(role) + mspdsa_dif ) * ATTR_RADIX)
	local defsb_dif = 50
	local defsb = DefSb(role) - defsb_dif
	SetCharaAttr(mxhpsb,role,ATTR_STATEV_MXHP)
	SetCharaAttr(mxspsb,role,ATTR_STATEV_MXSP)
	SetCharaAttr(mnatksb,role,ATTR_STATEV_MNATK)
	SetCharaAttr(mxatksb,role,ATTR_STATEV_MXATK)
	SetCharaAttr(mspdsa,role,ATTR_STATEC_MSPD)
	SetCharaAttr(defsb,role,ATTR_STATEV_DEF)
	ALLExAttrSet(role)
end

function State_EMZL_Rem(role,statelv)
	local mxhpsb_dif = 1000
	local mxhpsb = MxhpSb(role) - mxhpsb_dif
	local mxspsb_dif = 1000
	local mxspsb = MxspSb(role) - mxspsb_dif
	local mnatksb_dif = 250
	local mnatksb = MnatkSb(role) - mnatksb_dif
	local mxatksb_dif = 250
	local mxatksb = MxatkSb(role) - mxatksb_dif
	local mspdsa_dif = 0.5
	local mspdsa = math.floor ( (MspdSa(role) - mspdsa_dif ) * ATTR_RADIX)
	local defsb_dif = 50
	local defsb = DefSb(role) + defsb_dif
	SetCharaAttr(mxhpsb,role,ATTR_STATEV_MXHP)
	SetCharaAttr(mxspsb,role,ATTR_STATEV_MXSP)
	SetCharaAttr(mnatksb,role,ATTR_STATEV_MNATK)
	SetCharaAttr(mxatksb,role,ATTR_STATEV_MXATK)
	SetCharaAttr(mspdsa,role,ATTR_STATEC_MSPD)
	SetCharaAttr(defsb,role,ATTR_STATEV_DEF)
	ALLExAttrSet(role)  
end

--Rebirth Passive Skill
function Skill_Rbmp_Use( role , sklv )
	local statelv  = sklv
	local rb_bonus = (-1) * ( 0.050 + 0.005 * statelv ) -- Increases by 5.5%
	local mnatksa  = math.floor (  (MnatkSa (role) - rb_bonus ) * ATTR_RADIX )
	local mxatksa  = math.floor (  (MxatkSa (role) - rb_bonus ) * ATTR_RADIX )
	local defsa    = math.floor (  (DefSa   (role) - rb_bonus ) * ATTR_RADIX )
	local ResistSa = math.floor (  (ResistSa(role) - rb_bonus ) * ATTR_RADIX )
	SetCharaAttr( mnatksa  , role , ATTR_STATEC_MNATK )
	SetCharaAttr( mxatksa  , role , ATTR_STATEC_MXATK )
	SetCharaAttr( defsa    , role , ATTR_STATEC_DEF   )
	SetCharaAttr( ResistSa , role , ATTR_STATEC_PDEF  )
	ALLExAttrSet(role)
end

function Skill_Rbmp_Unuse( role , sklv )
	local statelv  = sklv
	local rb_bonus = (-1) * ( 0.050 + 0.005 * statelv ) -- Increases by 5.5%
	local mnatksa  = math.floor (  (MnatkSa (role) + rb_bonus ) * ATTR_RADIX )
	local mxatksa  = math.floor (  (MxatkSa (role) + rb_bonus ) * ATTR_RADIX )
	local defsa    = math.floor (  (DefSa   (role) + rb_bonus ) * ATTR_RADIX )
	local ResistSa = math.floor (  (ResistSa(role) + rb_bonus ) * ATTR_RADIX )
	SetCharaAttr( mnatksa  , role , ATTR_STATEC_MNATK )
	SetCharaAttr( mxatksa  , role , ATTR_STATEC_MXATK )
	SetCharaAttr( defsa    , role , ATTR_STATEC_DEF   )
	SetCharaAttr( ResistSa , role , ATTR_STATEC_PDEF  )
	ALLExAttrSet(role)
end