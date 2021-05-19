
import java.util.Scanner;
public class SolutionBa {
    public static void main(String[] args){
        Scanner scan = new Scanner(System.in);
        int n = scan.nextInt();
        int[] arrayA = new int[n];
        int[] arrayB = new int[n];
        int k = scan.nextInt();
        int i = 0;
        while ( i < n){
            arrayA[i] = scan.nextInt();
            arrayB[i] = scan.nextInt();
            i++;
        }
        System.out.println(answer(arrayA,arrayB,k,n));
    }
    public static int answer(int[] a,int[] b,int k,int len){
        int[][] opt = new int[len][k+1];
        int i = 0;
        while ( i < len){
            opt[i][0]= 0;
            i++;
        }
        i = 1;
        while( i < k+1){
            opt[0][i] = max(0,((a[0]*i)*i) + (b[0]*i));
            i++;
        }
        i = 1;
        int j = 1;
        while ( i < len){
            j = 1;
            while ( j < k+1){
                int l = j;
                int currentV = (a[i]*j*j) + (b[i]*j);
                //System.out.println(currentV);
                opt[i][j] = currentV;
                while ( l > -1){
                    opt[i][j] = max(opt[i][j],opt[i][l]+opt[i-1][j-l]);
                    l--;
                }
                opt[i][j] = max(0,opt[i][j]);
                j++;
            }
            i++;
        }
        return opt[len-1][k];
    }
    public static int max(int a,int b){
        if(a>b){
            return a;
        }
        return b;
    }
}
