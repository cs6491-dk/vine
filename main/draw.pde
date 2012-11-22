void drawCylinder(pt BC, pt TC, vec right, float radius) {
	//pushMatrix();
	//camera(BC.x, BC.y, BC.z, TC.x, TC.y, TC.z, up.x, up.y, up.z);

	int radial_segments = 8;

	vec axis = V(BC, TC);
	vec up = N(right, axis).normalize();
	float h = d(BC, TC);

	float angle, z;
	beginShape(TRIANGLE_STRIP);
	vec n;
	pt v;
	for (int idx=0; idx<=radial_segments; idx++) {
		angle = idx*2*PI/radial_segments;

		n = V(cos(angle), right, sin(angle), up);
		normal(n.x, n.y, n.z);

		v = P(BC);
		v.add(radius, n);
		if ((idx % 2) == 1) v.add(axis);
		vertex(v.x, v.y, v.z);
	}
	endShape();

	//popMatrix();
}
