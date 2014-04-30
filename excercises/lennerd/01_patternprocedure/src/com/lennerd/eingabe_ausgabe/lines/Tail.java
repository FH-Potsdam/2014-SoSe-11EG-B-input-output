package com.lennerd.eingabe_ausgabe.lines;

import processing.core.PGraphics;
import processing.core.PVector;

import java.util.ArrayList;

public class Tail extends ArrayList<PVector> implements java.io.Serializable {

    private final int maxSize;
    private final float weight;
    private float finalAngle;

    public Tail(int maxSize, PVector start, float weight) {
        super();

        this.maxSize = maxSize;
        this.weight = weight;
        add(start);
    }

    public void draw(PGraphics graphics) {
        graphics.strokeWeight(weight);

        PVector current = new PVector();

        graphics.beginShape();

        for (PVector step : this) {
            current.add(step);
            graphics.vertex(current.x, current.y);
        }

        graphics.endShape();
    }

    public boolean add(PVector step) throws TailMaxSizeException {
        int size = size();

        if (size >= maxSize) {
            throw new TailMaxSizeException();
        }

        if (!isEmpty()) {
            PVector last = get(size - 1);
            float angle = PVector.angleBetween(last, step);

            // Need this because of rounding errors
            if (angle < 0.01) {
                last.add(step);

                return false;
            }
        }

        finalAngle = step.heading();

        return super.add(step);
    }

    /*public ArrayList<PVector> getIntersections(Line other) {
        ArrayList<PVector> intersections = new ArrayList<PVector>();

        if (isEmpty()) {
            return intersections;
        }

        // Don't forget to copy the vector
        PVector current = new PVector();
        current.add(get(0));

        for (int i = 1; i < size(); i++) {
            PVector step = get(i);
            Line stepLine = new Line(current.x, current.y, step.x, step.y);
            PVector intersection = stepLine.getIntersection(other);

            if (intersection != null) {
                intersections.add(intersection);
            }

            current.add(step);
        }

        return intersections;
    }

    public boolean hasIntersections(Line other) {
        return !getIntersections(other).isEmpty();
    }*/

    public float weight() {
        return weight;
    }

    public float finalAngle() {
        return finalAngle;
    }

    public Intersection getIntersection(Line other) {
        if (isEmpty()) {
            return null;
        }

        // Don't forget to copy the vector
        PVector current = new PVector();
        current.add(get(0));

        for (int i = 1; i < size(); i++) {
            PVector step = get(i);
            Line stepLine = new Line(current.x, current.y, step.x, step.y);
            Intersection intersection = stepLine.getIntersection(other);

            if (intersection != null) {
                return intersection;
            }

            current.add(step);
        }

        return null;
    }

}
