$fn = 100;

stl_filename="balum124.stl";

module main() {
    projection(cut = false) {
        import(stl_filename);
    }
}

main();
