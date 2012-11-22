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
	      width = 2*radius;
	if ((leaves % 4) == 1) {
		angle = PI/6*((leaves % 5) + 1);
		vec leaf_up = V(cos(angle), right, sin(angle), up);
		vec leaf_right = N(axis, leaf_up).normalize();

		beginShape(TRIANGLE_STRIP);
		normal(axis.x, axis.y, axis.z);
		v = P(BC, radius, leaf_up, 0.5, axis);
		vertex(v.x, v.y, v.z);
		v.add(height/2, leaf_up);
		v.add(-width/2, leaf_right);
		vertex(v.x, v.y, v.z);
		v.add(width, leaf_right);
		vertex(v.x, v.y, v.z);
		v.add(-width/2, leaf_right);
		v.add(height/2, leaf_up);
		vertex(v.x, v.y, v.z);
		endShape();

		beginShape(TRIANGLE_STRIP);
		normal(-axis.x, -axis.y, -axis.z);
		v = P(BC, radius, leaf_up, 0.5, axis);
		vertex(v.x, v.y, v.z);
		v.add(height/2, leaf_up);
		v.add(width/2, leaf_right);
		vertex(v.x, v.y, v.z);
		v.add(-width, leaf_right);
		vertex(v.x, v.y, v.z);
		v.add(width/2, leaf_right);
		v.add(height/2, leaf_up);
		vertex(v.x, v.y, v.z);
		endShape();
	}
}
