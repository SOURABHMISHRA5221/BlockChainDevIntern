
import java.util.*;
public class SolutionA1 {
    public static void main(String[] args){
        Scanner scan = new Scanner(System.in);
        int t = scan.nextInt();
        while( t > 0){
            int n = scan.nextInt();
            int m = scan.nextInt();
            ArrayList<ArrayList<Integer>> AList = new ArrayList<>();
            ArrayList<ArrayList<Integer>> AListR = new ArrayList<>();
            int i = 0;
            while ( i < n){
                AList.add(new ArrayList<>());
                AListR.add(new ArrayList<>());
                i++;
            }
            int nearReach[] = new int[n];
            while ( m > 0){
                int u  = scan.nextInt()-1;
                int v  = scan.nextInt()-1;
                if ( v == n-1){
                    nearReach[u] = 1;
                }
                AList.get(u).add(v);
                AListR.get(v).add(u);

                m--;
            }
            boolean[] answer = new boolean[1];
            int[] nc = new int[n];
            newdfs(n-1,nc,AListR);
            dfs(0,n-1,AList,new int[n],nearReach,new int[n],0,answer,nc);
            if (answer[0]){
                System.out.println("yes");
            }
            else{
                System.out.println("no");
            }
            t--;
        }
    }
    public static int dfs(int start,int toReach, ArrayList<ArrayList<Integer>> AList,int[] colourArray,int[] nearReach,int[] timestamp,int time,boolean[] answer,int[] nc){
        colourArray[start] = 1;
        timestamp[start] = time++;
        int dbe = Integer.MAX_VALUE;
        int i = 0;
        int len = AList.get(start).size();
        while ( i < len){
            int v = AList.get(start).get(i);
            if ( colourArray[v] == 0){
                if ( v != toReach) {
                    dbe = min( dbe,dfs(v, toReach, AList, colourArray, nearReach, timestamp, time,answer,nc));
                }

            }
            else if (colourArray[v] == 1){
                dbe = min(dbe,timestamp[v]);
            }
            i++;
        }
        colourArray[start] = 2;
        //System.out.println("DBE of "+start+" "+dbe+" with time = "+timestamp[start]+" cv= "+colourArray[toReach] );
        if ( toReach != 0 && dbe <= timestamp[start] && nc[start]==2 ){

                answer[0] = true;

        }
        //colourArray[toReach] = 0;

        return dbe;
    }
    public static void newdfs(int start,int[] colour, ArrayList<ArrayList<Integer>> AList){
        colour[start] = 1;
        int i = 0;
        int len = AList.get(start).size();
        while ( i < len){
            int v = AList.get(start).get(i);
            if (colour[v] == 0){
                newdfs(v,colour,AList);
            }
            i++;
        }
        colour[start] = 2;
    }
    public static int min(int a,int b){
        if ( a < b){
            return  a;
        }
        return b;
    }
}
