package linksharing.enums

enum Seriousness {

    CASUAL(0),
    SERIOUS(1),
    VERY_SERIOUS(2),

    private final int val

    Seriousness(int val){
        this.val = val
    }


    int value() {
        return this.val;
    }
}
