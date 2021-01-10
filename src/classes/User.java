package classes;

public class User {
    private Long id;
    private String email;
    private String password;
    private String fullName;
    private String birthDate;
    private String pictureURL;


    public User(){ }

    public User(String email, String password, String fullName, String birthDate, String pictureURL) {
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.birthDate = birthDate;
        this.pictureURL = pictureURL;
    }

    public User(String email, String password, String fullName, String birthDate) {
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.birthDate = birthDate;
    }

    public User(Long id, String email, String password, String fullName, String birthDate, String pictureURL) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.birthDate = birthDate;
        this.pictureURL = pictureURL;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getPictureURL() {
        return pictureURL;
    }

    public void setPictureURL(String pictureURL) {
        this.pictureURL = pictureURL;
    }
}
