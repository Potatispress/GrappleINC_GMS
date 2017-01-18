draw_self();


if(!isHookedOn && lineOfSight && inRange){
    draw_set_colour(c_red);
    var dir = degtorad (point_direction(phy_com_x + offSetX,phy_com_y + offSetY, obj_player.phy_com_x, obj_player.phy_com_y - 5) + 90); //+90 cuz game maker sucks
    initialCheckDist = 700;
    checkDist = initialCheckDist;
    ray = collision_line(phy_com_x + offSetX,phy_com_y + offSetY, phy_com_x + sin(dir) * checkDist, phy_com_y + offSetY + cos(dir) * checkDist, obj_physics, false, true);
    
    if(ray){
        //checkDist /= 2;
        for(var i = 1; i < 20; i++){
            if(collision_line(phy_com_x + offSetX,phy_com_y + offSetY, x + sin(dir) * checkDist, y + offSetY + cos(dir) * checkDist, obj_physics, false, true)){
                checkDist -= initialCheckDist / power(2,i);
            } else {
                checkDist += initialCheckDist / power(2,i);
            }
        }
        colx = phy_com_x + sin(dir) * checkDist;
        coly = phy_com_y + cos(dir) * checkDist;
    } else {
        colx = phy_com_x + sin(dir) * initialCheckDist;
        coly = phy_com_y + cos(dir) * initialCheckDist;
    }
    draw_line_width(phy_com_x + offSetX,phy_com_y + offSetY, colx - 1, coly - 1, 0.5);
    draw_set_colour(c_black);
    
    if(obj_player.x > x && !facingRight){
        image_xscale = 1;
        facingRight = true;
    } else if (obj_player.x < x && facingRight){
        image_xscale = -1;
        facingRight = false;
    }
}
