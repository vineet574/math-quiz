import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Random rand = new Random();
        int score = 0, correctCount = 0, wrongCount = 0;
        int highScore = 0;

        System.out.println("🧠 Welcome to the Math Quiz!");
        System.out.println("Choose difficulty level: (1) Easy  (2) Medium  (3) Hard");
        int level = sc.nextInt();
        int maxNum = switch (level) {
            case 1 -> 10;
            case 2 -> 20;
            case 3 -> 50;
            default -> 20;
        };

        System.out.println("⏱️ You have 10 seconds per question. Type -1 to quit.");

        while (true) {
            int a = rand.nextInt(maxNum) + 1;
            int b = rand.nextInt(maxNum) + 1;
            int op = rand.nextInt(3); // 0=+, 1=-, 2=*

            int correct = switch (op) {
                case 0 -> a + b;
                case 1 -> a - b;
                default -> a * b;
            };

            String symbol = switch (op) {
                case 0 -> "+";
                case 1 -> "-";
                default -> "*";
            };

            System.out.print("What is " + a + " " + symbol + " " + b + "? ");

            long startTime = System.currentTimeMillis();
            int ans;
            try {
                ans = sc.nextInt();
            } catch (InputMismatchException e) {
                System.out.println("⛔ Invalid input. Exiting game.");
                break;
            }

            long timeTaken = (System.currentTimeMillis() - startTime) / 1000;

            if (ans == -1) {
                System.out.println("🏁 Game over! Final Score: " + score);
                System.out.println("✅ Correct: " + correctCount + " ❌ Wrong: " + wrongCount);
                System.out.println("🏆 High Score This Session: " + highScore);
                break;
            }

            if (timeTaken > 10) {
                System.out.println("⏰ Time's up! The correct answer was: " + correct);
                wrongCount++;
            } else if (ans == correct) {
                System.out.println("✅ Correct!");
                score++;
                correctCount++;
                highScore = Math.max(highScore, score);
            } else {
                System.out.println("❌ Wrong! The correct answer was: " + correct);
                wrongCount++;
            }
        }

        sc.close();
    }
}
