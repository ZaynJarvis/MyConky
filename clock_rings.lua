settings_table = {
	{
		name='time',
		arg='%S',
		max=60,
		bg_colour=0xffffff,
		bg_alpha=0.1,
		fg_colour=0xfe7173,
		fg_colour_grad=0x70947F,
		fg_alpha=0.6,
		x=160, y=155,
		radius=65,
		thickness=4,
		start_angle=0,
		end_angle=360
	},
	{
		name='cpu',
		arg='cpu1',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0xd83992,
		fg_colour_grad=0xd9a97a,
		fg_alpha=0.5,
		x=160, y=155,
		radius=75,
		thickness=5,
		start_angle=93,
		end_angle=208
	},
	{
		name='cpu',
		arg='cpu2',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0xd83992,
		fg_colour_grad=0xd9a97a,
		fg_alpha=0.5,
		x=160, y=155,
		radius=81,
		thickness=5,
		start_angle=93,
		end_angle=208
	},

	{
                name='cpu',
                arg='cpu3',
                max=100,
                bg_colour=0xffffff,
                bg_alpha=0.2,
                fg_colour=0xd83992,
                fg_colour_grad=0xd9a97a,
                fg_alpha=0.5,
                x=160, y=155,
                radius=87,
                thickness=5,
                start_angle=93,
                end_angle=208
        },

	{
                name='cpu',
                arg='cpu4',
                max=100,
                bg_colour=0xffffff,
                bg_alpha=0.2,
                fg_colour=0xd83992,
                fg_colour_grad=0xd9a97a,
                fg_alpha=0.5,
                x=160, y=155,
                radius=93,
                thickness=5,
                start_angle=93,
                end_angle=208
        },
	{
		name='memperc',
		arg='',
		max=100,
		bg_colour=0x00ffff,
		bg_alpha=0.2,
		fg_colour=0xF1F2B5,
		fg_colour_grad=0x135058,
		fg_alpha=0.5,
		x=160, y=155,
		radius=84,
		thickness=22.5,
		start_angle=212,
		end_angle=329
	},
	{
		name='time',
		arg='%M',
		max=60,
		bg_colour=0xff0000,
		bg_alpha=0.2,
		fg_colour=0x3e912a,
		fg_colour_grad=0xff955a,
		fg_alpha=0.5,
		x=160, y=155,
		radius=84,
		thickness=22.5,
		start_angle=-27,
		end_angle=88
	},
	{
		name='fs_used_perc',
		arg='/',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0xd83992,
		fg_colour_grad=0xd9a97a,
		fg_alpha=0.5,
		x=160, y=155,
		radius=105,
		thickness=5,
		start_angle=-120,
		end_angle=-1.5
	},
	{
		name='fs_used_perc',
		arg='/home',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0xd83992,
		fg_colour_grad=0xd9a97a,
		fg_alpha=0.5,
		x=160, y=155,
		radius=105,
		thickness=5,
		start_angle=1.5,
		end_angle=120
	},
}

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
	local w,h=conky_window.width,conky_window.height

	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fgc_g, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'],pt['fg_colour_grad'], pt['fg_alpha']

	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)


	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	local linpat 
	if pt['name'] == 'time' then linpat = cairo_pattern_create_linear (160, 0, 160, 320)
	else linpat = cairo_pattern_create_linear (50, 20, 180, 280) end
	cairo_pattern_add_color_stop_rgb (linpat, 0, rgb_to_r_g_b(fgc,fga))
	cairo_pattern_add_color_stop_rgb (linpat, 1, rgb_to_r_g_b(fgc_g,fga))
	cairo_set_source(cr, linpat)
	cairo_stroke(cr)
	cairo_pattern_destroy (linpat)

end
function draw_line(cr)
	local linpat = cairo_pattern_create_linear (267, 155, 868, 155)
	cairo_rectangle(cr, 267, 155, 600, 2)
	cairo_set_line_width (cr, 1)
	cairo_pattern_add_color_stop_rgba (linpat, 0, rgb_to_r_g_b(0xffffff,0.05))
	cairo_pattern_add_color_stop_rgba (linpat, 0.2, rgb_to_r_g_b(0xf13894,1.0))
	cairo_pattern_add_color_stop_rgba (linpat, 1, rgb_to_r_g_b(0xffffff,0))
	cairo_set_source(cr, linpat)
	cairo_fill(cr)
	cairo_pattern_destroy (linpat)
end

function draw_avatar(cr)
    local image, w, h
    cairo_arc (cr,160,155, 55, 0, 2*math.pi);
    cairo_clip (cr);
    cairo_new_path (cr);
    image = cairo_image_surface_create_from_png ("/home/zayn/Pictures/avatar");
    w = cairo_image_surface_get_width (image);
    h = cairo_image_surface_get_height (image);
    cairo_scale (cr, 100.0/w, 100.0/h);
    cairo_set_source_surface (cr, image, 107, 98);
    cairo_paint (cr);
    cairo_surface_destroy (image);
end

function conky_clock_rings()
	local function setup_rings(cr,pt)
                local str=''
                local value=0

                str=string.format('${%s %s}',pt['name'],pt['arg'])
                str=conky_parse(str)

                value=tonumber(str)
                if value == nil then value = 0 end
                if pt['arg'] == 'na' then value = 0 end
                pct=value/pt['max']

                draw_ring(cr,pct,pt)
    end
    
    
	
	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
    
	local cr=cairo_create(cs)	
    
	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)
    
	if update_num>0.1 then
		for i in pairs(settings_table) do
			setup_rings(cr,settings_table[i])
		end
        draw_line(cr)
        draw_avatar(cr)
	end
end