import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Random rand = new Random();
        int score = 0;

        System.out.println("🧠 Welcome to the Math Quiz!");
        System.out.println("Answer the questions correctly. Type -1 to quit.");

        while (true) {
            int a = rand.nextInt(20) + 1; // 1 to 20
            int b = rand.nextInt(20) + 1;
            int op = rand.nextInt(3); // 0 = +, 1 = -, 2 = *

            int correct = switch (op) {
                case 0 -> a + b;
                case 1 -> a - b;
                default -> a * b;
            };

            System.out.print("What is " + a + (op == 0 ? " + " : op == 1 ? " - " : " * ") + b + "? ");
            int ans = sc.nextInt();

            if (ans == -1) {
                System.out.println("🏁 Game over! Your final score: " + score);
                break;
            }

            if (ans == correct) {
                System.out.println("✅ Correct!");
                score++;
            } else {
                System.out.println("❌ Wrong! The correct answer was: " + correct);
            }
        }
    }
}
