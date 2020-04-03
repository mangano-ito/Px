on 'develop' => sub {
    requires 'Data::Printer';
};

on 'test' => sub {
    requires 'Test::Class';
    requires 'Test2::V0';
};
