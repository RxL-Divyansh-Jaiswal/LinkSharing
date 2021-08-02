package linksharing.enums

enum Visibility {
    Private(0),

    Public(1),

    private final int val

    Visibility(int val){
        this.val = val
    }


    int value() {
        return this.val;
    }
}
