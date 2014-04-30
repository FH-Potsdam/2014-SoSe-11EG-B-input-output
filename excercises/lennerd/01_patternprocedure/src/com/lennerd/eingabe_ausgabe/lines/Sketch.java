package com.lennerd.eingabe_ausgabe.lines;

import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PVector;
import processing.pdf.PGraphicsPDF;

import java.awt.event.MouseEvent;
import java.io.*;
import java.util.ArrayList;

public class Sketch extends PApplet {
    public static final float MIN_PENCIL_WEIGHT = 0.1F;
    public static final float MAX_PENCIL_WEIGHT = 0.5F;
    public static final float MIN_PENCIL_STEP = 2F;
    public static final float MAX_PENCIL_STEP = 5F;
    public static final float MIN_PENCIL_ROTATION = 0.05F;
    public static final float MAX_PENCIL_ROTATION = 0.1F;
    public static final float PENCIL_LENGTH = 20;
    public static final int MAX_TILE_SIZE = 100;
    public static final int PENCIL_COUNT = 1000;
    public static final int GRID_COLS = 5;
    public static final int GRID_ROWS = 6;

    private static Sketch instance;
    private ArrayList<Pencil> pencils;
    private ArrayList<Tail> inspiration;

    private int cell;
    private int background;
    private int foreground;
    private int iteration;
    private boolean drawInspiration;
    private boolean drewPencil;
    private PGraphicsPDF pdf;

    public void setup() {
        size(600, 600);
        strokeJoin(ROUND);

        drawInspiration = false;
        background = 0;
        foreground = 255;

        startPDF();
        startCell();
    }

    private Pencil createPencil(float sx, float sy, PVector arrow, float weight) {
        return new Pencil(sx, sy, arrow.x, arrow.y, weight);
    }

    private Pencil createPencil() {
        return createPencil(random(width), random(height), PVector.random2D(this), random(MIN_PENCIL_WEIGHT, MAX_PENCIL_WEIGHT));
    }

    public ArrayList<Tail> inspiration() {
        return inspiration;
    }

    public int foreground() {
        return foreground;
    }

    public int background() {
        return background;
    }

    private void fillPencils() {
        ArrayList<Tail> leftTails = loadTails(leftCell());
        ArrayList<Tail> rightTails = loadTails(rightCell());
        ArrayList<Tail> topTails = loadTails(topCell());
        ArrayList<Tail> bottomTails = loadTails(bottomCell());

        pencils = new ArrayList<Pencil>();
        inspiration = new ArrayList<Tail>();

        //stroke(255, 0, 0, 100);
        //strokeWeight(10);

        if (leftTails != null) {
            Line rightBorder = new Line(width, 0, 0, height);
            //rightBorder.draw();

            inspiration.addAll(leftTails);

            for (Tail leftTail : leftTails) {
                Intersection intersection = leftTail.getIntersection(rightBorder);

                if (intersection != null) {
                    Pencil pencil = createPencil(0, intersection.y, PVector.fromAngle(leftTail.finalAngle()), leftTail.weight());
                    pencils.add(pencil);
                    //pencil.draw();
                }
            }
        }

        if (rightTails != null) {
            Line leftBorder = new Line(0, 0, 0, height);
            //leftBorder.draw();

            inspiration.addAll(rightTails);

            for (Tail rightTail : rightTails) {
                Intersection intersection = rightTail.getIntersection(leftBorder);

                if (intersection != null) {
                    Pencil pencil = createPencil(width, intersection.y, PVector.fromAngle(rightTail.finalAngle()), rightTail.weight());
                    pencils.add(pencil);
                    //pencil.draw();
                }
            }
        }

        if (topTails != null) {
            Line bottomBorder = new Line(0, height, width, 0);
            //bottomBorder.draw();

            inspiration.addAll(topTails);

            for (Tail topTail : topTails) {
                Intersection intersection = topTail.getIntersection(bottomBorder);

                if (intersection != null) {
                    Pencil pencil = createPencil(intersection.x, 0, PVector.fromAngle(topTail.finalAngle()), topTail.weight());
                    pencils.add(pencil);
                    //pencil.draw();
                }
            }
        }

        if (bottomTails != null) {
            Line topBorder = new Line(0, 0, width, 0);
            //topBorder.draw();

            inspiration.addAll(bottomTails);

            for (Tail bottomTail : bottomTails) {
                Intersection intersection = bottomTail.getIntersection(topBorder);

                if (intersection != null) {
                    Pencil pencil = createPencil(intersection.x, height, PVector.fromAngle(bottomTail.finalAngle()), bottomTail.weight());
                    pencils.add(pencil);
                    //pencil.draw();
                }
            }
        }

        //background = map(min(pencils.size(), PENCIL_COUNT), 0, PENCIL_COUNT, 200, 0);

        for (int i = pencils.size(); i < PENCIL_COUNT; i++) {
            pencils.add(createPencil());
        }

        //stop();
    }

    public void draw() {
        draw(g);

        if (!drewPencil) {
            finishCell();
        }

        if (drawInspiration) {
            drawInspiration();
        }
    }

    public void draw(PGraphics graphics) {
        graphics.background(background);

        drawPencils(graphics);
        drawInfo(graphics);
    }

    public void drawPencils(PGraphics graphics) {
        drewPencil = false;

        for (Pencil pencil : pencils) {
            if (!pencil.finished()) {
                drewPencil = true;
            }

            pencil.draw(graphics);
        }
    }

    public void startPDF() {
        if (pdf != null) {
            finishPDF();
        }

        pdf = (PGraphicsPDF) createGraphics(width, height, PDF, getNextVersionFilename());
        pdf.beginDraw();
    }

    public void drawPDFPage() {
        if (iteration > 1) {
            pdf.nextPage();
        }

        draw(pdf);
    }

    public void finishPDF() {
        pdf.dispose();
        pdf.endDraw();
    }

    public void drawInfo(PGraphics graphics) {
        graphics.fill(foreground);
        graphics.textSize(12);
        graphics.textAlign(RIGHT, BOTTOM);
        graphics.text(cell + " — " + iteration, width - 10, height - 10);
    }

    public void drawInspiration() {
        noFill();
        stroke(255, 0, 0);

        for (Tail thought : inspiration) {
            thought.draw(g);
        }
    }

    public ArrayList<Pencil> pencils() {
        return pencils;
    }

    private void finish() {
        finishPDF();
        clearTails();
        println("Finished!");
        exit();
    }

    private void finishCell() {
        saveCell();
        drawPDFPage();
        startCell();
    }

    private void saveCell() {
        saveTails(cell);
    }

    private void startCell() {
        cell = chooseCell();

        // No cells left so exit
        if (cell == -1) {
            finish();
            return;
        }

        println("New Cell: " + cell);
        iteration++;

        fillPencils();
    }

    private void saveTails(int grid) {
        saveTails(new File(createTailFilename(grid)));
    }

    private void saveTails(File file) {
        ByteArrayOutputStream byteOut = new ByteArrayOutputStream();

        try {
            ObjectOutputStream out = new ObjectOutputStream(byteOut);

            for (Pencil pencil : pencils) {
                out.writeObject(pencil.tail());
            }

            out.close();
            byteOut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        saveBytes(file, byteOut.toByteArray());
    }

    private ArrayList<Tail> loadTails(int cell) {
        if (!cellFilled(cell)) {
            return null;
        }

        return loadTails(new File(createTailFilename(cell)));
    }

    private ArrayList<Tail> loadTails(File file) {
        ArrayList<Tail> tails = new ArrayList<Tail>();
        byte[] bytes = loadBytes(file);
        ByteArrayInputStream byteIn = new ByteArrayInputStream(bytes);

        try {
            ObjectInputStream in = new ObjectInputStream(byteIn);
            Tail tail;

            try {
                while (null != (tail = (Tail) in.readObject())) {
                    tails.add(tail);
                }
            } catch (EOFException ignored) {
                return tails;
            } finally {
                in.close();
                byteIn.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    private void clearTails() {
        int[] cells = new int[GRID_COLS * GRID_ROWS];

        // Fill
        for (int i = 0; i < cells.length; i++) {
            cells[i] = i + 1;
        }

        for (int cell : cells) {
            if (cellFilled(cell)) {
                File file = new File(createTailFilename(cell));
                file.delete();
            }
        }
    }

    private int chooseCell() {
        int[] cells = new int[GRID_COLS * GRID_ROWS];

        // Fill
        for (int i = 0; i < cells.length; i++) {
            cells[i] = i + 1;
        }

        // Shuffle
        for (int i = 0; i < cells.length; i++) {
            int j = round(random(cells.length - 1));
            int k = cells[j];

            cells[j] = cells[i];
            cells[i] = k;
        }

        // Whether grid has minimum one cell filled
        boolean gridFilled = false;

        // Choose
        for (int newCell : cells) {
            if (cellFilled(newCell)) {
                gridFilled = true;
                continue;
            }

            // No surrounding cells
            if (cellFilled(topCell(newCell)) ||
                cellFilled(bottomCell(newCell)) ||
                cellFilled(leftCell(newCell)) ||
                cellFilled(rightCell(newCell))) {

                return newCell;
            }
        }

        // Grid has no filled cell yet, so start with the first one (shuffled)
        if (!gridFilled) {
            return cells[0];
        }

        // No cells left
        return -1;
    }

    private int topCell() {
        return topCell(cell);
    }

    private int topCell(int i) {
        int top = i - GRID_COLS;

        if (top < 1) {
            return -1;
        }

        return top;
    }

    private int bottomCell() {
        return bottomCell(cell);
    }

    private int bottomCell(int i) {
        int bottom = i + GRID_COLS;

        if (bottom > GRID_ROWS * GRID_COLS) {
            return -1;
        }

        return bottom;
    }

    private int leftCell() {
        return leftCell(cell);
    }

    private int leftCell(int i) {
        if (i < 1) {
            return -1;
        }

        int j = (i % GRID_COLS);

        if (j == 1) {
            return -1;
        }

        return i - 1;
    }

    private int rightCell() {
        return rightCell(cell);
    }

    private int rightCell(int i) {
        if (i > GRID_COLS * GRID_ROWS) {
            return -1;
        }

        int j = (i % GRID_COLS);

        if (j == 0) {
            return -1;
        }

        return i + 1;
    }

    private boolean cellFilled(int i) {
        if (i == -1) {
            return false;
        }

        File file = new File(createTailFilename(i));

        return file.exists();
    }

    private static String createTailFilename(int cell) {
        return "tails" + cell + ".ser";
    }

    private static String createVersionFilename(int id) {
        return "version" + id + ".pdf";
    }

    private static String getNextVersionFilename() {
        int version = 0;
        String filename;
        File file;

        do {
            filename = createVersionFilename(++version);
            file = new File(filename);
        } while(file.exists());

        return filename;
    }

    @Override
    public void mousePressed() {
        drawInspiration = true;
    }

    @Override
    public void mouseReleased(MouseEvent e) {
        drawInspiration = false;
    }

    private Sketch() {
    }

    public static Sketch getInstance() {
        if (instance == null) {
            instance = new Sketch();
        }
        return instance;
    }

    public static void main(String args[]) {
        Sketch sketch = Sketch.getInstance();

        args = concat(new String[]{Sketch.class.getName()}, args);

        runSketch(args, sketch);
    }

}
