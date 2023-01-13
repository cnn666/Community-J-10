dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")
dofile(LockOn_Options.script_path.."materials.lua")

local HUD_IND_TEX_PATH        = LockOn_Options.script_path .. "HMD New/"  

SetScale(FOV)

stringdefs = {0.012,0.75 * 0.012, 0, 0}
HMD_strdefs_text = {0.009, 0.009, 0, 0}
HMD_strdefs_digit = {0.009,0.009, 0, 0}
HUD_strdefs_text  = {0.009,0.009, 0, 0}
HUD_strdefs_digit = {0.007,0.007, 0, 0}
HUD_pitch_digit = {0.006,0.006, 0, 0}
HUD_Heading_digit = {0.005,0.005, 0, 0}
HUD_strdefs_digit_f = {0.01,0.0028, 0, 0}
HUD_whenYouCantFindTheDigit = {0.1,0.1, 0, 0}

HUD_HorizonLineHeading = {0.005,0.005, 0.0080, 0.0080}



materials = {}
materials["DBG_GREY"]    = {5, 5, 5, 255}
materials["DBG_BLACK"]   = {0, 0, 0, 255}
materials["DBG_BLUE"]    = {0, 0, 100, 255}
materials["DBG_GREEN"]   = {0,255,0,255}	
materials["DBG_YELLOW"]   = {255,   0,   0, 240}
materials["DBG_RED"]     = {255, 0, 0, 255}
materials["DBG_WHITE"]   = {255, 255, 255, 255}
materials["DBG_CYAN"]    = {1, 244, 244, 255}
materials["BASE_GREEN"]  = {0,255,0, 255}


materials["BGCOLOR"]    = MakeMaterial(nil,{242, 235, 179,255})

materials["MWHITE"]     = MakeMaterial(nil, materials["DBG_WHITE"])
materials["BBLACK"]     = MakeMaterial(nil, materials["DBG_BLACK"])

-------FONTS-------
local IndicationFontPath = LockOn_Options.script_path.."Resources/fonts/"
local BASE_COLOR  = {36,255,113,255}
local GREEN 		= {0,255,0,255}
 
fontdescription = {}

CMFD_X_PIXEL =  88
CMFD_Y_PIXEL =  144

local Gripen_Font = fonts["hud_font_g"]


Gripen_Font_green  	= fonts["hud_font_g"]


fonts = {}
fonts["FONT_WHITE"]  = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"},materials["DBG_WHITE"],50,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
fonts["FONT_BLUE"]   = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"},materials["DBG_BLUE"],50,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
fonts["FONT_RED"]    = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"},materials["DBG_RED"],50,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
fonts["FONT_GREEN"]  = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"}, materials["DBG_GREEN"],50,"test_font") 
fonts["FONT_BLACK"]  = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"}, materials["DBG_BLACK"],50,"test_font") 
fonts["FONT_WHITE"]  = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"}, materials["DBG_WHITE"],50,"test_font") 

fonts["Gripen_Font_green"]  = Gripen_Font_green


--all vertices in files who include this file will be scaled in millyradians
-- SetScale(MILLYRADIANS)
 
DEGREE_TO_MRAD = 17.4532925199433
DEGREE_TO_RAD  = 0.0174532925199433
RAD_TO_DEGREE  = 57.29577951308233
MRAD_TO_DEGREE = 0.05729577951308233

HMD_DEFAULT_LEVEL = 2     
HUD_DEFAULT_LEVEL = 2                               
HUD_DEFAULT_NOCLIP_LEVEL  = HUD_DEFAULT_LEVEL - 1  
 

HUD_DAY_COLOR               = {255,255,255,255}
HUD_DARK_COLOR               = {0,0,0,255}


HMD_HORIZON = MakeMaterial(HUD_IND_TEX_PATH.."JAS_HUD_Symbols", GREEN)
HMD_POSITIVE_PITCH = MakeMaterial(HUD_IND_TEX_PATH.."PitchLines", GREEN)
HMD_NEGATIVE_PITCH = MakeMaterial(HUD_IND_TEX_PATH.."PitchLinesNegative", GREEN)
HMD_HeadingScale = MakeMaterial(HUD_IND_TEX_PATH.."HUD_HeadingScale", GREEN)
HMD_AimingCircle = MakeMaterial(HUD_IND_TEX_PATH.."WVR_AimingCircle", GREEN)
HMD_AimingCircleThin = MakeMaterial(HUD_IND_TEX_PATH.."WVR_AimingCircleThin", GREEN)
HMD_GroundCollisionWarning = MakeMaterial(HUD_IND_TEX_PATH.."GroundCollisionWarning", GREEN)
HMD_Circle = MakeMaterial(HUD_IND_TEX_PATH.."HMD_CIRCLE", GREEN)


default_HUD_x = 512
default_HUD_y = 512

default_HUD_z_offset = 0.8
default_HUD_rot_offset = 30

local box_indices =
{
	0,1,2;0,2,3
}

function create_HMD_Circle(HUD_material, UL_X,UL_Y,DR_X,DR_Y, sale,CENTER_X,CENTER_Y)

	if sale == nil then
		sale = 1.4
	end
	
	local mils_per_pixel =  sale/1024
	local W 	   		 = DR_X - UL_X
	local H 	   		 = DR_Y - UL_Y
	local cx		     = (UL_X + 0.5 * W)
	local cy		     = (UL_Y + 0.5 * H)
	
	local CENTER_X 		 = CENTER_X or cx
	local CENTER_Y 		 = CENTER_Y or cy
	local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
	local dcy 		     = mils_per_pixel * (CENTER_Y - cy)
	
	local half_x 		 = 0.49 * W * mils_per_pixel
	local half_y 		 = 0.49 * H * mils_per_pixel
	
	
	local object = CreateElement "ceTexPoly"
		  object.material =  HUD_material
		   object.vertices =  {{-half_x - dcx, half_y + dcy},
							  { half_x - dcx, half_y + dcy},
							  { half_x - dcx,-half_y + dcy},
							  {-half_x - dcx,-half_y + dcy}}
		  object.tex_coords = HMD_texture_box(UL_X,UL_Y,W,H, 2048, 2048)
		  object.indices	  = box_indices
		  return object
	end

function HMD_texture_box (UL_X,UL_Y,W,H, texture_size_x, texture_size_y)
local ux = UL_X / texture_size_x
local uy = UL_Y / texture_size_y
local w  = W / texture_size_x
local h  = H / texture_size_y
return {{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}}
end
 
function create_HMD_tex(HUD_material, UL_X,UL_Y,DR_X,DR_Y, sale,CENTER_X,CENTER_Y)

if sale == nil then
	sale = 1.4
end

local mils_per_pixel =  sale/512
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.49 * W * mils_per_pixel
local half_y 		 = 0.49 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  HUD_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = HMD_texture_box(UL_X,UL_Y,W,H, 1024, 1024)
	  object.indices	  = box_indices
	  return object
end

function create_HMD_GCW(HUD_material, UL_X,UL_Y,DR_X,DR_Y, sale,CENTER_X,CENTER_Y)

if sale == nil then
	sale = 1.4
end

local mils_per_pixel =  sale/1450
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.49 * W * mils_per_pixel
local half_y 		 = 0.49 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  HUD_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = HMD_texture_box(UL_X,UL_Y,W,H, 2900, 1600)
	  object.indices	  = box_indices
	  return object
end

function HMD_Heading_Scale(mfd_material, UL_X,UL_Y,DR_X,DR_Y, sale,CENTER_X,CENTER_Y)

if sale == nil then
	sale = 1.25
end

local mils_per_pixel =  sale/4200
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  mfd_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy, 0.1},
						  { half_x - dcx, half_y + dcy, 0.1},
						  { half_x - dcx,-half_y + dcy, 0.1},
						  {-half_x - dcx,-half_y + dcy, 0.1}}
	  object.tex_coords = HMD_texture_box(UL_X,UL_Y,W,H, 8400, 200)
	  object.indices	  = box_indices
	 -- object.use_mipfilter    = true
	 -- object.additive_alpha   = true
	  --object.collimated		  = true
	  --object.blend_mode 	=  blend_mode.IBM_REGULAR
	  --object.h_clip_relation  = h_clip_relations.COMPARE
	  object.level            = HMD_DEFAULT_LEVEL
	  return object
end





function HMD_Horizon_Line(mfd_material, UL_X,UL_Y,DR_X,DR_Y, sale,CENTER_X,CENTER_Y)

if sale == nil then
	sale = 1.25
end

local mils_per_pixel =  sale/1650
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.47 * W * mils_per_pixel
local half_y 		 = 0.49 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  mfd_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy, 0.1 },
						  { half_x - dcx, half_y + dcy, 0.1 },
						  { half_x - dcx,-half_y + dcy, 0.1 },
						  {-half_x - dcx,-half_y + dcy, 0.1 }}
	  object.tex_coords = HMD_texture_box(UL_X,UL_Y,W,H, 3328, 2048)
	  object.indices	  = box_indices
	 -- object.use_mipfilter    = true
	 -- object.additive_alpha   = true
	  --object.collimated		  = true
	  --object.blend_mode 	=  blend_mode.IBM_REGULAR
	  --object.h_clip_relation  = h_clip_relations.COMPARE
	  object.level            = HMD_DEFAULT_LEVEL
	  return object
end


function create_hdg_textr_box(vth_hdg_material, UL_X,UL_Y,DR_X,DR_Y,scale, CENTER_X,CENTER_Y)

if scale == nil then
	scale = 1.4
end

local mils_per_pixel =  scale/4096

local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  vth_hdg_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = HMD_texture_box(UL_X,UL_Y,W,H, 4096,64)
	  object.indices	  = box_indices
	  return object
end

function create_HMD_tex_sq(HUD_material, UL_X,UL_Y,DR_X,DR_Y, sale,CENTER_X,CENTER_Y)

if sale == nil then
	sale = 1.4
end

local mils_per_pixel =  sale/1024
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  HUD_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = HMD_texture_box(UL_X,UL_Y,W,H,2048,2048)
	  object.indices	  = box_indices
	  return object
end

function create_hdg_text_d(UL_X,UL_Y,DR_X,DR_Y, CENTER_X,CENTER_Y)
local mils_per_pixel =  2.2/1024

local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel
local object = CreateElement "ceTexPoly"
	  object.material =  HUD_RPM_DIGIT_D
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = HMD_texture_box(UL_X,UL_Y,W,H, 31, 324)
	  object.indices	  = box_indices
	  return object
end




function HMD_vert_gen(width, height)
    return {{(0 - width) / 2 / default_HUD_x , (0 + height) / 2 / default_HUD_y},
    {(0 + width) / 2 / default_HUD_x , (0 + height) / 2 / default_HUD_y},
    {(0 + width) / 2 / default_HUD_x , (0 - height) / 2 / default_HUD_y},
    {(0 - width) / 2 / default_HUD_x , (0 - height) / 2 / default_HUD_y},}
end

function HMD_duo_vert_gen(width, total_height, not_include_height)
    return {
        {(0 - width) / 2 / default_HUD_x , (0 + total_height) / 2 / default_HUD_y},
        {(0 + width) / 2 / default_HUD_x , (0 + total_height) / 2 / default_HUD_y},
        {(0 + width) / 2 / default_HUD_x , (0 + not_include_height) / 2 / default_HUD_y},
        {(0 - width) / 2 / default_HUD_x , (0 + not_include_height) / 2 / default_HUD_y},
        {(0 + width) / 2 / default_HUD_x , (0 - not_include_height) / 2 / default_HUD_y},
        {(0 - width) / 2 / default_HUD_x , (0 - not_include_height) / 2 / default_HUD_y},
        {(0 + width) / 2 / default_HUD_x , (0 - total_height) / 2 / default_HUD_y},
        {(0 - width) / 2 / default_HUD_x , (0 - total_height) / 2 / default_HUD_y},
    }
end

function tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{x_dis / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},}
end

function mirror_tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{(x_dis + width) / size_X , y_dis / size_Y},
			{x_dis / size_X , y_dis / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},}
end

function AddHMDElement(object)
	object.h_clip_relation  = h_clip_relations.COMPARE	--INCREASE_IF_LEVEL  
	object.level  		 	= HMD_DEFAULT_LEVEL 
    object.use_mipfilter    = true
	object.additive_alpha   = true
    object.collimated       = true
	object.blend_mode 		=  blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    Add(object)
end

function AddHMDElement2(object)
    object.collimated       = true
	object.use_mipfilter    = true
	object.additive_alpha   = true
	object.blend_mode 		=  blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
    Add(object)
end

function AddHMDElement3(object)
    object.collimated       = true
	object.use_mipfilter    = true
	object.additive_alpha   = true
	object.blend_mode 		=  blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
	object.h_clip_relation  = h_clip_relations.DECREASE_IF_LEVEL 
	object.level  		 	= HMD_DEFAULT_LEVEL + 1
    Add(object)
end

function AddHMDElement4(object)
	object.h_clip_relation  = h_clip_relations.COMPARE	--INCREASE_IF_LEVEL  
	object.level  		 	= HMD_DEFAULT_LEVEL 
    object.isdraw           = true
    object.isvisible        = true
    object.use_mipfilter    = true
    object.additive_alpha   = true
    object.collimated       = true
	object.blend_mode 		=  blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
	parent.element_params 	= {"HUD_BRIGHTNESS"}
	parent.controllers    	= {{"opacity_using_parameter", 0}}
    Add(object)
end






function create_line(PosX, PosY, lLenght, lwidth, parent, material, vertices)
	vmaterial =  materials["MWHITE"]
	if material ~= nil then
		vmaterial =  materials[material]
	end
	vvertices = {{0, 0}, {lLenght,0}}
	if material ~= nil then
		vvertices = vertices
	end	
	line_object				 = CreateElement "ceSimpleLineObject"
	line_object.name		 = create_guid_string()
	line_object.material	 = vmaterial
	line_object.width		 = lwidth
	line_object.vertices	 =  vvertices
	line_object.init_pos     = {PosX, PosY}
	line_object.parent_element	= parent.name
	-- AddHUDElement(line_object)
	return line_object
end

function create_rect(xpos, ypos, bw, bh, Border, parent, material)
	local rec_parent       		= CreateElement "ceSimple"
	rec_parent.name				= create_guid_string()
	rec_parent.init_pos       	= {xpos, ypos}
	rec_parent.parent_element	= parent.name
	
	local  rect_top_line 		= create_line(0 ,0 , bw * 2, Border, rec_parent, material)
	rect_top_line.init_pos 		= {-bw,bh}
	AddHMDElement(rect_top_line)

	local  rect_bottom_line = Copy(rect_top_line)
	rect_bottom_line.init_pos 	= {-bw, -bh}
	AddHMDElement(rect_bottom_line)

	local  rect_left_line 		= create_line(Border ,0 , Border, bh , rec_parent, material)
	rect_left_line.init_pos 	= {-bw +(Border ) - 0.005, 0}
	AddHMDElement(rect_left_line)

	local  rect_right_line = Copy(rect_left_line)
	rect_right_line.init_pos 	= { bw -(Border ) , 0}
	AddHMDElement(rect_right_line)
	
	return rec_parent
end


function AddHMDCircle(xpos, ypos, radius, border, fill, parent_element, color)
	if border <=0 then
		border = 1
	end
	if color == nil then
		color =  "DBG_GREEN"
	end
	for i=1, border do
		    RWR_circle_i 				= CreateElement "ceMeshPoly"
			RWR_circle_i.name 			= create_guid_string()
			RWR_circle_i.primitivetype 	= "triangles"
			RWR_circle_i.init_pos       = {xpos, ypos}
			if fill == true then
				set_circle	(RWR_circle_i, radius + 0.0020 )
			else
				set_circle	(RWR_circle_i, radius + 0.003, radius - 0.003, 360, 180)
			end
			RWR_circle_i.material 		= color
			RWR_circle_i.parent_element = parent_element
			-- AddHUDElement(RWR_circle_i)
			radius = radius + 0.001
	end
	

	return RWR_circle_i
end


function AddCircle_b(xpos, ypos, radius, border, fill, parent_element, color)

	local rec_parent       		= CreateElement "ceSimple"
	rec_parent.name				= create_guid_string()
	rec_parent.init_pos       	= {xpos, ypos}
	rec_parent.parent_element	= parent_element
	-- AddHUDElement(rec_parent)
	
	if border <=0 then
		border = 1
	end
	if color == nil then
		color =  "DBG_GREEN"
	end
	for i=1, border do
		    RWR_circle_i 				= CreateElement "ceMeshPoly"
			RWR_circle_i.name 			= create_guid_string()
			RWR_circle_i.primitivetype 	= "triangles"
			RWR_circle_i.init_pos       = {0 , 0}
			if fill == true then
				set_circle	(RWR_circle_i, radius + 0.0020 )
			else
				set_circle	(RWR_circle_i, radius + 0.0020, radius - 0.0020, 360, 36)
			end
			RWR_circle_i.material 		= color
			RWR_circle_i.parent_element = rec_parent.name
			AddHMDElement(RWR_circle_i)
			radius = radius + 0.001
	end
	

	return rec_parent
end

function add_text_HMD(text, posx, posy, pparent, font_mat, stringdefs, valign)

	local rec_parent       		= CreateElement "ceSimple"
	rec_parent.name				= create_guid_string()
	rec_parent.init_pos       	= {posx, posy}
	if pparent ~= nil then
		rec_parent.parent_element	= pparent.name
	end
	AddHMDElement(rec_parent)
	-------------------
	if valign == nil then
		valign = "CenterCenter"
	end
	vfont_mat = fonts["FONT_GREEN"]
	if font_mat ~= nil then
		vfont_mat = fonts[font_mat]
	end
	if stringdefs == nil then
		stringdefs = HUD_strdefs_text
	end		
	-------------------
	if text ~= nil then
		local parent          = CreateElement "ceStringPoly"
		parent.name           = create_guid_string()
		parent.material       = vfont_mat
		parent.init_pos       = {0, 0}
		parent.stringdefs     = stringdefs
		parent.alignment	  = valign
		parent.value  	      = text
		parent.parent_element = rec_parent.name
		parent.element_params 	= {"HUD_BRIGHTNESS"}
		parent.controllers    	= {{"opacity_using_parameter", 0}}
		AddHMDElement(parent)
	end
	-------------------
	return rec_parent
end

function add_text_HMD_param(posx, posy, element_parm, element_parm2, tformat, pparent, stringdefs, font_mat, talignment)
	if tformat == nil then
		tformat = "%.0f"
	end
	if talignment == nil then
		talignment = "CenterCenter"
	end
	vfont_mat = fonts["FONT_GREEN"]
	if font_mat ~= nil then
		vfont_mat = fonts[font_mat]
	end	
	if stringdefs == nil then
		stringdefs = HUD_strdefs_text
	end	
	
	local parent          = CreateElement "ceStringPoly"
	parent.name           = create_guid_string()
	parent.material       = vfont_mat
	parent.init_pos       = {posx, posy}
	parent.stringdefs     = stringdefs
	parent.alignment	  = talignment
	if pparent ~= nil then
		parent.parent_element = pparent.name
	end
	parent.formats           = {tformat} 
	parent.element_params    = {element_parm2, element_parm,"%s"}
	parent.controllers       = {{"opacity_using_parameter", 0},{"text_using_parameter",1}}
	AddHMDElement(parent)
	-------------------
	return parent
end




function add_text_HMD2(text, posx, posy, pparent, font_mat, stringdefs, valign)

	local rec_parent       		= CreateElement "ceSimple"
	rec_parent.name				= create_guid_string()
	rec_parent.init_pos       	= {posx, posy, 0.1}
	if pparent ~= nil then
		rec_parent.parent_element	= pparent.name
	end
	AddHMDElement(rec_parent)
	-------------------
	if valign == nil then
		valign = "CenterCenter"
	end
	vfont_mat = fonts["FONT_GREEN"]
	if font_mat ~= nil then
		vfont_mat = fonts[font_mat]
	end
	if stringdefs == nil then
		stringdefs = HUD_strdefs_text
	end		
	-------------------
	if text ~= nil then
		local parent          = CreateElement "ceStringPoly"
		parent.name           = create_guid_string()
		parent.material       = vfont_mat
		parent.init_pos       = {0, 0}
		parent.stringdefs     = stringdefs
		parent.alignment	  = valign
		parent.value  	      = text
		parent.parent_element = rec_parent.name
		parent.element_params 	= {"HUD_BRIGHTNESS"}
		parent.controllers    	= {{"opacity_using_parameter", 0}}
		AddHMDElement3(parent)
	end
	-------------------
	return rec_parent
end

