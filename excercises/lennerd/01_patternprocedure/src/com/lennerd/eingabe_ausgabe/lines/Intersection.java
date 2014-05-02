package com.lennerd.eingabe_ausgabe.lines;

import processing.core.PVector;

public class Intersection extends PVector {

    private final float angle;

    public Intersection(float x, float y, float angle) {
        super(x, y);

        this.angle = angle;
    }

    public float angle()
    {
        return angle;
    }
}
