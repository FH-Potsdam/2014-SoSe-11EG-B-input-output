package com.lennerd.eingabe_ausgabe.lines;

import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PVector;

public class Pencil extends Line {

    private final Tail tail;
    private final float step;
    private final float weight;
    private final float rotation;
    //private final int color;
    private boolean finished;

    public Pencil(float sx, float sy, float ax, float ay, float weight) {
        super(sx, sy, ax, ay);

        this.weight = PApplet.constrain(weight, Sketch.MIN_PENCIL_WEIGHT, Sketch.MAX_PENCIL_WEIGHT);

        //this.color = calcColor(this.weight);

        tail = new Tail(Sketch.MAX_TILE_SIZE, start.get(), this.weight);
        finished = false;

        step = PApplet.map(this.weight, Sketch.MIN_PENCIL_WEIGHT, Sketch.MAX_PENCIL_WEIGHT, Sketch.MAX_PENCIL_STEP, Sketch.MIN_PENCIL_STEP);
        rotation = PApplet.map(this.weight, Sketch.MIN_PENCIL_WEIGHT, Sketch.MAX_PENCIL_WEIGHT, Sketch.MAX_PENCIL_ROTATION, Sketch.MIN_PENCIL_ROTATION);

        setMag(Sketch.PENCIL_LENGTH);
    }

    @Override
    public void draw(PGraphics graphics) {
        Sketch sketch = Sketch.getInstance();

        graphics.strokeWeight(weight);
        graphics.noFill();

        graphics.stroke(sketch.foreground());
        tail.draw(graphics);

        graphics.stroke(sketch.foreground());
        super.draw(graphics);

        if (finished) {
            return;
        }

        if (!inSurface()) {
            finish();
            return;
        }

        try {
            move();
        } catch (TailMaxSizeException exception) {
            finish();
            return;
        }

        rotate();
    }

    private void move() throws TailMaxSizeException {
        PVector step = normalize(null);
        step.mult(this.step);

        tail.add(step);
        start.add(step);
    }

    private void rotate() {
        /*if (!this.rotateByInspiration()) {
            this.rotateBySiblings();
        }*/

        rotate(this.rotateByInspiration());
        rotate(this.rotateBySiblings());
    }

    private int rotateBySiblings() {
        Sketch sketch = Sketch.getInstance();
        int fullRotate = 0;

        for (Pencil other : sketch.pencils()) {
            if (other == this) {
                continue;
            }

            Intersection intersection = other.tail().getIntersection(this);

            if (intersection != null) {
                float absAngle = PApplet.abs(intersection.angle());

                absAngle = PApplet.radians(PApplet.round(PApplet.degrees(absAngle)));

                if (absAngle == PApplet.HALF_PI) {
                    continue;
                }

                // Move to the orthogonal direction
                // Take into account in which direction we leave the other line
                int rotate = intersection.angle() > 0 ? 1 : -1;

                if (absAngle > PApplet.HALF_PI) {
                    rotate *= -1;
                }

                fullRotate += rotate;
            }
        }

        return fullRotate;
    }

    private int rotateByInspiration() {
        Sketch sketch = Sketch.getInstance();
        int fullRotate = 0;

        for (Tail thought : sketch.inspiration()) {
            Intersection intersection = thought.getIntersection(this);

            if (intersection != null) {
                float absAngle = PApplet.abs(intersection.angle());

                absAngle = PApplet.radians(PApplet.round(PApplet.degrees(absAngle)));

                if (absAngle == 0 || absAngle == PApplet.PI) {
                    continue;
                }

                // Move to the orthogonal direction
                // Take into account in which direction we leave the other line
                int rotate = intersection.angle() > 0 ? 1 : -1;

                if (absAngle < PApplet.HALF_PI) {
                    rotate *= -1;
                }

                fullRotate += rotate;
            }
        }

        return fullRotate;
    }

    /*private boolean rotateBySiblings() {
        Sketch sketch = Sketch.getInstance();

        for (Pencil other : sketch.pencils()) {
            if (other == this) {
                continue;
            }

            Intersection intersection = other.tail().getIntersection(this);

            if (intersection != null) {
                float absAngle = PApplet.abs(intersection.angle());

                absAngle = PApplet.radians(PApplet.round(PApplet.degrees(absAngle)));

                if (absAngle == PApplet.HALF_PI) {
                    return true;
                }

                // Move to the orthogonal direction
                // Take into account in which direction we leave the other line
                int rotate = intersection.angle() > 0 ? 1 : -1;

                if (absAngle > PApplet.HALF_PI) {
                    rotate *= -1;
                }

                rotate(rotate);
                return true;
            }
        }

        return false;
    }

    private boolean rotateByInspiration() {
        Sketch sketch = Sketch.getInstance();

        for (Tail thought : sketch.inspiration()) {
            Intersection intersection = thought.getIntersection(this);

            if (intersection != null) {
                float absAngle = PApplet.abs(intersection.angle());

                absAngle = PApplet.radians(PApplet.round(PApplet.degrees(absAngle)));

                if (absAngle == 0 || absAngle == PApplet.PI) {
                    return true;
                }

                // Move to the orthogonal direction
                // Take into account in which direction we leave the other line
                int rotate = intersection.angle() > 0 ? 1 : -1;

                if (absAngle < PApplet.HALF_PI) {
                    rotate *= -1;
                }

                rotate(rotate);
                return true;
            }
        }

        return false;
    }*/

    public void rotate(float direction) {
        super.rotate(rotation * direction);
    }

    public float weight() {
        return weight;
    }

    public Tail tail() {
        return tail;
    }

    public boolean inSurface() {
        Sketch sketch = Sketch.getInstance();

        return !(start.x < 0 || start.x > sketch.width || start.y < 0 || start.y > sketch.height);
    }

    public void finish() {
        if (finished) {
            return;
        }

        try {
            this.move();
        } catch(TailMaxSizeException ignored) {}

        finished = true;
    }

    /*public static int calcColor(float weight) {
        Sketch sketch = Sketch.getInstance();

        int color = PApplet.round(PApplet.map(weight, Sketch.MIN_PENCIL_WEIGHT, Sketch.MAX_PENCIL_WEIGHT, 16777215, 0));

        int red = (color & 255 << 16) >> 16;
        int green = (color & 255 << 8) >> 8;
        int blue = (color & 255);

        return sketch.color(red, green, blue);
    }*/

    public boolean finished() {
        return finished;
    }
}
