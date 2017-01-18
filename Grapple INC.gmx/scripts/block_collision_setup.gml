
var fix = physics_fixture_create();

physics_fixture_set_box_shape(fix, 16 * image_xscale / 2, 16 * image_yscale / 2);

//physics_fixture_set_kinematic(fix);

physics_fixture_set_density(fix, 0);
physics_fixture_set_angular_damping(fix, 0.1);
physics_fixture_set_linear_damping(fix, 0.1);
physics_fixture_set_friction(fix, 0.2);
physics_fixture_set_restitution(fix, 0.1);
physics_fixture_set_awake(fix, true);

physics_fixture_bind_ext(fix, id, -16 * image_xscale / 2, -16 * image_yscale / 2);


