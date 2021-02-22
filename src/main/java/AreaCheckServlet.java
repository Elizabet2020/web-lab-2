import com.fasterxml.jackson.databind.ObjectMapper;
import table.TableRow;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static java.lang.Math.sqrt;

@WebServlet("/area")
public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        long start = System.nanoTime();
        ObjectMapper objectMapper = new ObjectMapper();
        HttpSession session = request.getSession(true);
        response.setContentType("text/json;charset=UTF-8");
        PrintWriter writer = response.getWriter();

        if (session.getAttribute("data") == null) {
            session.setAttribute("data", new ArrayList<TableRow>() {});

        }
        ArrayList<TableRow> table = (ArrayList<TableRow>) session.getAttribute("data");

        //if (validateValues(request.getParameter("x"), request.getParameter("y"), request.getParameter("r"))){
        double x = Double.parseDouble(request.getParameter("x"));
        double y = Double.parseDouble(request.getParameter("y"));
        double r = Double.parseDouble(request.getParameter("r"));
        boolean check = false;
        if (x>=0 && y<=0 && x<=r && y>=-r) {
            check = true;
        }

        double peak = -r/2;
        double x1 = 0;
        double y1 = 0;
        double x2 = 0;
        double y2 = peak;
        double x3 = peak;
        double y3 = 0;

        double a = (x1 - x) * (y2 - y1) - (x2 - x1) * (y1 - y);
        double b = (x2 - x) * (y3 - y2) - (x3 - x2) * (y2 - y);
        double c = (x3 - x) * (y1 - y3) - (x1 - x3) * (y3 - y);

        if ((a>=0 && b>=0 && c>=0) || (a<=0 && b<=0 && c<=0) || a==0 || b==0|| c==0){
            check = true;
        }

        if (x<=0 && x<=r/2 && y>=0 && y<=r/2 && y<=sqrt(r*r/4 - x*x)){
            check = true;
        }

        long timeWorkCode = System.nanoTime() - start;

        Date date = new Date();
        DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        String formatDate = dateFormat.format(date);
        table.add(
                new TableRow(x, y, r, check, formatDate, timeWorkCode)
        );
        session.setAttribute("data", table);
        writer.println(objectMapper.writeValueAsString(table));
//        writer.println(table);
        writer.close();
    }

    private boolean validateValues(String x, String y, String r){
        return validateX(x) && validateY(y) && validateR(r);
    }

    private boolean validateX(String xString){
        try{
            int[] array = new int[] {-5, -4, -3, -2, -1, 0, 1, 2, 3};
            int x = Integer.parseInt(xString);
            for (int value : array) {
                if (value == x) {
                    return true;
                }
            }
            return false;
        }catch (NumberFormatException e){
            return false;
        }
    }
    private boolean validateY(String yString){
        try{
            double y = Double.parseDouble(yString);
            return y > -3 && y < 5;
        } catch (NumberFormatException e){
            return false;
        }
    }
    private boolean validateR(String rString){
        try{
            double r = Double.parseDouble(rString);
            return r > 1 && r<4;
        } catch (NumberFormatException e){
            return false;
        }
    }
}