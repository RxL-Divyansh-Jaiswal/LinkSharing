package linksharing.enums

enum Seriousness {

    Casual(0),
    Serious(1),
    Very_Serious(2),

    private final int val

    Seriousness(int val){
        this.val = val
    }


    int value() {
        return this.val;
    }
}
