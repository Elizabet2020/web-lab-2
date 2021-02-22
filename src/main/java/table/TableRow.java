package table;

import java.io.Serializable;

public class TableRow implements Serializable {
    public double X;
    public double Y;
    public double R;
    public boolean result;
    public String dateTime;
    public long executionTime;

    public TableRow(double x, double y, double r, boolean result, String dateTime, long executionTime) {
        this.X = x;
        this.Y = y;
        this.R = r;
        this.result = result;
        this.dateTime = dateTime;
        this.executionTime = executionTime;
    }

    public double getX() {
        return this.X;
    }

    public void setX(double x) {
        this.X = x;
    }

    public double getY() {
        return this.Y;
    }

    public void setY(double y) {
        this.Y= y;
    }

    public double getR() {
        return this.R;
    }

    public void setR(double r) {
        this.R = r;
    }

    public boolean getResult() {
        return this.result;
    }

    public void setX(boolean result) {
        this.result = result;
    }

    public String getDateTime() {
        return this.dateTime;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    public double getExecutionTime() {
        return this.executionTime;
    }

    public void setExecutionTime(long executionTime) {
        this.executionTime = executionTime;
    }
}
