
import java.util.*;
public class SolutionBb{
    public static void main(String[] args){
        Scanner scan = new Scanner(System.in);
        int n = scan.nextInt();
        long a[]  = new long[n];
        long b[]  = new long[n];
        long   m[]  = new long[n];
        int j = scan.nextInt();
        int i = 0;
        PriorityQueue<node> pq = new PriorityQueue<>(n,new nodeComparator());
        while ( i < n){
            a[i] = scan.nextLong();
            b[i] = scan.nextLong();
            i++;
        }
        i = 0;
        int k = 0;
        long answer = 0;
        while ( k < j){
            i = 0;
            long minP = 0;
            int index = n+1;
            while ( i < n){
                long next = (2*m[i]+1)*a[i]+b[i];
                if (next > minP){
                    index = i;
                    minP = next;
                }
                i++;
            }
            if ( minP == 0){
                break;
            }
            else{
                answer+=minP;
                m[index]+=1;
            }
            k++;
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
        sub = a;
        n = 0;

    }
}

class nodeComparator implements Comparator<node>{

    @Override
    public int compare(node o1, node o2) {
        if ( o1.b/(-1*o1.a) > o2.b/(-1*o2.a) ){
            return -1;
        }
        else if ((o1.b / (-1 * o1.a)) == (o2.b / (-1 * o2.a)) && o1.b > o2.b){
            return -1;
        }
        else if ((o1.b / (-1 * o1.a)) == (o2.b / (-1 * o2.a)) && o1.b == o2.b){
            return 0;
        }
        else{
            return 1;
        }
    }
}

class Heap{
    node[] heap;
    int size;
    public Heap(){
        heap = new node[100000];
        size = 0;
    }
    void insert(node n){
        int i = size;
        heap[size] = n;
        size++;
        while ( i > 0 && compareRatio(i,(i-1)/2)){
            node temp = heap[(i-1)/2];
            heap[(i-1)/2] = heap[i];
            heap[i] = temp;
            i = (i-1)/2;
        }
    }
    node extractMax(){
        node temp = heap[0];
        heap[0] = heap[size-1];
        size--;
        heapify(0);
        return temp;
    }
    void heapify(int i){
        int n = size-1;
        boolean flag = true;
        while ( i <= (n-1)/2 && flag){
            int max= i;
            if ( !compareRatio(i,2*i+1)){
                max = 2*i +1;
            }
            if ( 2*i +2 <= n && !compareRatio(max,2*i+2)){
                max = 2*i+2;
            }
            if ( max != i){
                node temp = heap[max];
                heap[max] = heap[i];
                heap[i] = temp;
                i = max;
            }
            else{
                flag = false;
            }
        }
    }
    boolean compareRatio(int i,int j){
        if ( heap[i].b/(-1*heap[i].a) > heap[j].b/(-1*heap[j].a) ){
            return true;
        }
        else return heap[i].b / (-1 * heap[i].a) == heap[j].b / (-1 * heap[j].a) && heap[i].b > heap[j].b;
    }
}