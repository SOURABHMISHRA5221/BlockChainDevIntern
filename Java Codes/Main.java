
import java.util.Scanner;
public class Main {

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        int n1 = scan.nextInt();
        int n2 = scan.nextInt();
        int n3 = scan.nextInt();
        if ( n1+n2 > n3 ){
            System.out.println(n3+n2);
        }
        
            if ( n3 > n1+n2) {
                int pair = (n1+n2);
                System.out.println(pair+1+n2);
            }
            else if ( n3 == n1+n2){
                System.out.println(n2+n3);
            }
        
    }
    public static int maxHouse(int[] array,int budget){
        int len = array.length;
        int[][] opt = new int[len][budget+1];
        int i = 0;
        while ( i < len){
            opt[i][0] = 0;
            i++;
        }
        i = 0;
        while ( i < budget+1){
            if( array[0] > i){
                opt[0][i]  = 0;
            }
            else{
                opt[0][i] = 1;
            }
            i++;
        }
        i = 1;
        int j = 1;
        while ( i < len){
            j = 1;
            while(j < budget+1){
                if(array[i]> j){
                    opt[i][j] = opt[i-1][j];
                    //System.out.print("opt["+i+","+j+"] = "+opt[i][j]+" ");
                }
                else{
                    int a = opt[i-1][j];
                    int b = opt[i-1][j-array[i]] + 1;
                    int max = -1;
                    if( a> b){
                        max = a;
                    }
                    else{
                        max = b;
                    }
                    opt[i][j] = max;
                }
                //System.out.print("opt["+i+","+j+"] = "+opt[i][j]+" ");
                j++;
            }
            //System.out.println();
            i++;
        }

        return opt[len-1][budget];
    }
}
