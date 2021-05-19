
import java.util.*;
public class Mainb{
    public static void main(String[] args){
        Scanner scan = new Scanner(System.in);
        int n = scan.nextInt();
        int k = scan.nextInt();
        int i = 0;
        PriorityQueue<node> pq = new PriorityQueue<>(n,new nodeComparator());
        while ( i < n){
            double a = scan.nextDouble();
            double b = scan.nextDouble();
            if ( -1*a < b){
                pq.add(new node(a,b));
            }
            i++;
        }
        i = 0;
        long answer = 0;
        while ( pq.size() != 0 && i < k){
            node current = pq.poll();
            answer += (current.b + current.a);
            current.a+=current.sub;
            if ( -1*current.a < current.b){
                pq.add(current);
            }
            i++;
        }
        System.out.println(answer);
    }
}

class node{
    double a;
    double b;
    double sub;
    int n;
    public node(double A,double B){
        a = A;
        b = B;
        sub = 2*a;
        n = 0;

    }
}

class nodeComparator implements Comparator<node>{

    @Override
    public int compare(node o1, node o2) {
        if ( o1.b+o1.a > o2.a+o2.b ){
            return -1;
        }
        else if (o1.b+o1.a == o2.a+o2.b){
            return 0;
        }
        else{
            return 1;
        }
    }
}
