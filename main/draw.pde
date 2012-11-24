void drawVine(pt BC, pt TC, vec right, float radius, boolean half, int leaves) {
	int radial_segments = 12;

	vec axis = V(BC, TC);
	vec up = N(right, axis).normalize();
	float h = d(BC, TC);

	float angle, z;
	beginShape(TRIANGLE_STRIP);
	vec n;
	pt v;
	int max;
	if (half) max = radial_segments/2+1;
	else max = radial_segments+1;
	for (int idx=-1; idx<=max; idx++) {
		angle = idx*2*PI/radial_segments;

		n = V(cos(angle), right, sin(angle), up);
		normal(n.x, n.y, n.z);

		v = P(BC, radius, n);
		if ((idx % 2) == 1) v.add(axis);
		vertex(v.x, v.y, v.z);
	}
	endShape();

	float height = 4.5*radius,
	      width = 2*radius,
	      depth = 0.5*radius;
	if ((leaves % 4) == 1) {
		angle = PI/6*((leaves % 5) + 1);
		vec leaf_up = V(cos(angle), right, sin(angle), up);
		vec leaf_right = N(axis, leaf_up).normalize();
		vec leaf_front = N(leaf_right, leaf_up);

		pt leaf[] = new pt[5];
		leaf[0] = P(BC, radius, leaf_up, 0.5, axis);					// bottom
		leaf[1] = P(leaf[0], height/2, leaf_up, -depth, leaf_front);	// center
		leaf[2] = P(leaf[0], height/2, leaf_up, -width/2, leaf_right);	// left
		leaf[3] = P(leaf[2], width, leaf_right);						// right
		leaf[4] = P(leaf[0], height, leaf_up);							// top

		beginShape(TRIANGLE_FAN);
		n = N(leaf[1], leaf[2], leaf[0]).normalize();
		normal(n.x, n.y, n.z);
		vertex(leaf[1].x, leaf[1].y, leaf[1].z);
		vertex(leaf[0].x, leaf[0].y, leaf[0].z);
		vertex(leaf[2].x, leaf[2].y, leaf[2].z);

		n = N(leaf[1], leaf[4], leaf[2]).normalize();
		normal(n.x, n.y, n.z);
		vertex(leaf[4].x, leaf[4].y, leaf[4].z);

		n = N(leaf[1], leaf[3], leaf[4]).normalize();
		normal(n.x, n.y, n.z);
		vertex(leaf[3].x, leaf[3].y, leaf[3].z);

		n = N(leaf[1], leaf[0], leaf[3]).normalize();
		normal(n.x, n.y, n.z);
		vertex(leaf[0].x, leaf[0].y, leaf[0].z);
		endShape();
	}
}
