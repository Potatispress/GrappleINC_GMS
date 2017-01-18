///player_create()

player_height = 18;
player_width = 8;

fix = physics_fixture_create()
//physics_fixture_set_box_shape(fix, sprite_width / 2, sprite_height / 2);
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix, 6, 1);
physics_fixture_add_point(fix, 7, 2);
physics_fixture_add_point(fix, 7, 13);
physics_fixture_add_point(fix, 4, player_height - 0.5);
physics_fixture_add_point(fix, 1, 13);
physics_fixture_add_point(fix, 1, 2);
physics_fixture_add_point(fix, 2, 1);

physics_fixture_set_angular_damping(fix, 0.1);
physics_fixture_set_awake(fix, true);
physics_fixture_set_density(fix, 0.1);
physics_fixture_set_friction(fix, 2);
physics_fixture_set_linear_damping(fix, 0.1);
physics_fixture_set_restitution(fix, 0);

fix_player = physics_fixture_bind_ext(fix, id, player_width / 2, player_height / 2);

keyLeft = ord('A');
keyRight = ord('D');
keyJump = vk_space;
keySlow = mb_right;
facing = 1;
maxSpd = 4;

alarmTimeMax = 1000;
alarmTimeMin = 700;
alarmed = false;

moveForce = 50 * phy_mass;
jumpForce = -12.4 * phy_mass;

phy_fixed_rotation = true;
phy_bullet = true;


pullForce = 70;

jointList = ds_list_create();
joint = 0;

image_speed = 1/6;

slowMotion = true;
hookToggling = true;

connected = false;
keyUp = ord('W');
keyDown = ord('S');

curSpd = 0;
oldSpd = 0;

onGround = false;

canJump = true;

physics_world_update_iterations(25);


