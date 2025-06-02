import java.util.*;

public class Main {
    static Scanner sc = new Scanner(System.in);
    static List<String> questionHistory = new ArrayList<>();
    static Map<String, Integer> playerScores = new HashMap<>();

    public static void main(String[] args) {
        Random rand = new Random();
        int score = 0, correctCount = 0, wrongCount = 0, streak = 0;
        int highScore = 0;
        List<Integer> sessionScores = new ArrayList<>();

        System.out.print("👤 Enter your name: ");
        String username = sc.nextLine();

        System.out.println("🧠 Welcome to the Math Quiz, " + username + "!");
        System.out.println("Choose difficulty level: (1) Easy  (2) Medium  (3) Hard");
        int level = sc.nextInt();
        String levelName = switch (level) {
            case 1 -> "Easy";
            case 2 -> "Medium";
            case 3 -> "Hard";
            default -> "Medium";
        };
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
                while (b == 0 || a % b != 0) {
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

            String question = a + " " + symbol + " " + b;
            System.out.print("What is " + question + "? ");

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
                playerScores.put(username + " (" + levelName + ")", score);

                gradeReport(score, correctCount + wrongCount);
                printHistory();
                printLeaderboard(playerScores);
                break;
            }

            if (timeTaken > 10) {
                System.out.println("⏰ Time's up! The correct answer was: " + correct);
                wrongCount++;
                streak = 0;
                questionHistory.add("❌ " + question + " = " + correct + " (Too Slow)");
            } else if (ans == correct) {
                streak++;
                int bonus = (streak >= 3) ? 2 : 1;
                System.out.println("✅ Correct! +" + bonus + " points");
                if (streak == 3) System.out.println("🔥 Streak bonus activated!");
                score += bonus;
                correctCount++;
                highScore = Math.max(highScore, score);
                questionHistory.add("✅ " + question + " = " + correct);
            } else {
                System.out.println("❌ Wrong! The correct answer was: " + correct);
                wrongCount++;
                streak = 0;
                questionHistory.add("❌ " + question + " = " + correct + " (Your answer: " + ans + ")");
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

    static void printHistory() {
        System.out.println("\n📝 Question History:");
        for (String q : questionHistory) {
            System.out.println(q);
        }
    }

    static void printLeaderboard(Map<String, Integer> scores) {
        System.out.println("\n🏅 Session Leaderboard:");
        scores.entrySet().stream()
            .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
            .forEach(entry -> System.out.println(entry.getKey() + ": " + entry.getValue() + " pts"));
    }
}
