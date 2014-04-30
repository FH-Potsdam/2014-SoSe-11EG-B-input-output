package com.lennerd.eingabe_ausgabe.lines;

import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PVector;

public class Line extends PVector {

    protected PVector start;

    public Line(float sx, float sy, float ax, float ay) {
        super(ax, ay);

        start = new PVector(sx, sy);
    }

    public PVector start() {
        return start;
    }

    public PVector end() {
        return PVector.add(this.start, this);
    }

    public void draw(PGraphics graphics) {
        graphics.line(start().x, start().y, end().x, end().y);
    }

    /**
     * @link http://wiki.processing.org/w/Line-Line_intersection
     *
     * @return PVector
     */
    /*public PVector getIntersection(Line other) {
        PVector b = PVector.sub(end(), start);
        PVector d = PVector.sub(other.end(), other.start());

        float bDotDPerp = b.x * d.y - b.y * d.x;

        if (bDotDPerp == 0) {
            return null;
        }

        PVector c = PVector.sub(other.start(), start);

        float t = (c.x * d.y - c.y * d.x) / bDotDPerp;

        if (t < 0 || t > 1) {
            return null;
        }

        float u = (c.x * b.y - c.y * b.x) / bDotDPerp;

        if (u < 0 || u > 1) {
            return null;
        }

        return new PVector(start().x + t * b.x, start.y + t * b.y);
    }

    public boolean getIntersection(Line other) {
        return getIntersection(other) != null;
    }*/

    public Intersection getIntersection(Line other) {
        PVector b = PVector.sub(end(), start);
        PVector d = PVector.sub(other.end(), other.start());

        float bDotDPerp = b.x * d.y - b.y * d.x;

        if (bDotDPerp == 0) {
            return null;
        }

        PVector c = PVector.sub(other.start(), start);

        float t = (c.x * d.y - c.y * d.x) / bDotDPerp;

        if (t < 0 || t > 1) {
            return null;
        }

        float u = (c.x * b.y - c.y * b.x) / bDotDPerp;

        if (u < 0 || u > 1) {
            return null;
        }

        float angle = PVector.angleBetween(this, other);
        float heading = heading();
        float otherHeading = other.heading();

        if (otherHeading > (heading - PApplet.PI) && otherHeading < heading) {
            angle *= -1;
        }

        return new Intersection(start().x + t * b.x, start.y + t * b.y, angle);
    }

}
