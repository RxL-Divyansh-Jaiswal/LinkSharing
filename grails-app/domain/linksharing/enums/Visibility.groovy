package linksharing.enums

enum Visibility {
    PRIVATE(0),

    PUBLIC(1),

    private final int val

    Visibility(int val){
        this.val = val
    }


    int value() {
        return this.val;
    }
}
