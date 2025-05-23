import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Random rand = new Random();
        int score = 0, correctCount = 0, wrongCount = 0, streak = 0;
        int highScore = 0;
        List<Integer> sessionScores = new ArrayList<>();

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
            int op = rand.nextInt(4); // 0=+, 1=-, 2=*, 3=/

            int correct;
            String symbol;
            if (op == 3) {
                while (a % b != 0) {
                    a = rand.nextInt(maxNum) + 1;
                    b = rand.nextInt(maxNum) + 1;
                }
                correct = a / b;
                symbol = "/";
            } else {
                correct = switch (op) {
                    case 0 -> a + b;
                    case 1 -> a - b;
                    default -> a * b;
                };
                symbol = switch (op) {
                    case 0 -> "+";
                    case 1 -> "-";
                    default -> "*";
                };
            }

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
                System.out.println("🔥 Highest Score This Session: " + highScore);
                sessionScores.add(score);
                gradeReport(score, correctCount + wrongCount);
                printLeaderboard(sessionScores);
                break;
            }

            if (timeTaken > 10) {
                System.out.println("⏰ Time's up! The correct answer was: " + correct);
                wrongCount++;
                streak = 0;
            } else if (ans == correct) {
                streak++;
                int bonus = (streak >= 3) ? 2 : 1;
                System.out.println("✅ Correct! +" + bonus + " points");
                if (streak == 3) System.out.println("🔥 Streak bonus activated!");
                score += bonus;
                correctCount++;
                highScore = Math.max(highScore, score);
            } else {
                System.out.println("❌ Wrong! The correct answer was: " + correct);
                wrongCount++;
                streak = 0;
            }
        }

        sc.close();
    }

    static void gradeReport(int score, int total) {
        if (total == 0) return;
        double percent = (score * 100.0) / total;
        char grade = (percent >= 90) ? 'A' : (percent >= 75) ? 'B' : (percent >= 50) ? 'C' : 'D';
        System.out.printf("📊 Your Accuracy: %.1f%% - Grade: %c\n", percent, grade);
    }

    static void printLeaderboard(List<Integer> scores) {
        System.out.println("\n🏅 Session Leaderboard:");
        scores.sort(Collections.reverseOrder());
        for (int i = 0; i < scores.size(); i++) {
            System.out.println("#" + (i + 1) + ": " + scores.get(i) + " pts");
        }
    }
}
