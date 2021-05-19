package first;
import java.util.*;
public class SolutionB1 {
    public static void main(String[] args){
        Scanner scan = new Scanner(System.in);
        int n =scan.nextInt();
        int e = scan.nextInt();
        int k = scan.nextInt();
        int[][] AMatrix = new int[n][n];
        int[][] weights = new int[n][n];
        int i = 0;
        while (i <e){
            int u = scan.nextInt();
            int v = scan.nextInt();
            int w = scan.nextInt();
            AMatrix[u][v] = 1;
            AMatrix[v][u] = 1;
            weights[u][v] = w;
            weights[v][u] = w;
            i++;
        }
        System.out.println(bfs(n,0,AMatrix,new int[n],weights,new int[n],k));


    }
    public static long bfs(int size,int start,int[][] AMatrix,int[] visited,int[][] weights,int[] distance,int k){
        ArrayList<Integer> stack = new ArrayList<>();
        int[][] distanceTraveled = new int[size][size];
        stack.add(start);
        long answer = 0;
        while(stack.size()!= 0){
            int v = stack.remove(0);
            visited[v] = 1;
            int i = 0;
            while ( i < size){
                if(AMatrix[v][i] == 1) {
                    if (visited[i] == 0) {
                        if ( distance[v]+weights[v][i] >k){
                            if ( distance[v] < k){
                                int c = k - distance[v];
                                if ( distanceTraveled[v][i]+c <= weights[v][i]){
                                    distanceTraveled[v][i]+=c;
                                    distanceTraveled[i][v]+=c;
                                    answer+=c;
                                    //System.out.println("C vala chla");
                                    //System.out.println("Weight added between "+v+" "+i+" vo bhi "+ c);

                                }
                            }
                        }
                        else if ( distance[v]+weights[v][i] <k){
                            distance[i] = distance[v]+weights[v][i];
                            stack.add(i);
                            distanceTraveled[v][i] = weights[v][i];
                            distanceTraveled[i][v] = weights[v][i];
                            answer += weights[v][i]-1;
                            //System.out.println("Distance v = "+distance[v]);
                            //System.out.println("Weight added between "+v+" "+i+" vo bhi "+ weights[v][i]);
                        }
                        else{
                            distanceTraveled[v][i] = weights[v][i];
                            distanceTraveled[i][v] = weights[v][i];
                            distance[i] = distance[v]+weights[v][i];
                            answer += weights[v][i]-1;
                            visited[i] = 1;
                            //System.out.println("Distance v = "+distance[v]);
                            //System.out.println("Weight added between "+v+" "+i+" vo bhi "+ weights[v][i]);

                        }

                    }
                    else{
                        int c = k - distance[v];
                        if ( distanceTraveled[v][i]+c <= weights[v][i]){
                            distanceTraveled[v][i]+=c;
                            answer+=c;
                            //System.out.println("C vala chla");
                            //System.out.println("Weight added between "+v+" "+i+" vo bhi "+ c);

                        }
                    }
                }
                i++;
            }

        }
        int i = 0;
        while (i < size){
            if (visited[i]==1){
                answer++;
            }
            i++;
        }
        return answer;
    }
}
