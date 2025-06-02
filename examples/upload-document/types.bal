type CustomNodeEntry record {|
    string id;
    string name;
    record {|
        string id;
        string displayName;
    |} createdByUser;
|};
