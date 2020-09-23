require'nvim_lsp'.jdtls.setup {
    on_attach = function(client)
        require'completion'.on_attach(client)
        require'diagnostic'.on_attach(client)
        print "LSP attached"
    end;
    init_options = {
        jvm_args = {
            "-javaagent:"..os.getenv("HOME").."/.m2/repository/org/projectlombok/lombok/1.18.12/lombok-1.18.12.jar"
        };
    };
}
