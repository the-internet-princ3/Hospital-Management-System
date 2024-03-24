import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

public class Login extends javax.swing.JFrame {

    private final String DB_URL = "jdbc:mysql://localhost:3306/hospital_db";
    private final String DB_USER = "admin";
    private final String DB_PASSWORD = "admin";

    private Connection con;
    private PreparedStatement pst;
    private ResultSet rs;

    public Login() {
        initComponents();
        connectToDatabase();
        TextUserType.setSelectedIndex(-1);
    }

    private void connectToDatabase() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(this, "Error connecting to the database.");
        }
    }

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {
        String username = TextUsername.getText().trim();
        String password = new String(TextPassword.getPassword()).trim();
        String userType = TextUserType.getSelectedItem().toString();

        try {
            String query = "SELECT * FROM users WHERE User_Name = ? AND Password = ? AND User_Type = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password);
            pst.setString(3, userType);

            rs = pst.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("ID");
                this.setVisible(false);
                new Main(userId, username, userType).setVisible(true);
            } else {
                JOptionPane.showMessageDialog(this, "Invalid username, password, or user type.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(this, "Error executing query.");
        }
    }

    // Other methods and variables remain unchanged
}
