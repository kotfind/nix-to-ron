<table>
    <tr>
        <th>RON type</th>
        <th>RON</th>
        <th>Nix (full form)</th>
        <th>Nix (short form)</th>
    </tr>
    <!-- Number -->
    <tr>
        <td>Number</td>
        <td>42</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "number";
    value = 42;
}
            </pre>
        </td>
        <td>42</td>
    </tr>
    <!-- Bool -->
    <tr>
        <td>Bool</td>
        <td>true</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "bool";
    value = true;
}
            </pre>
        </td>
        <td>true</td>
    </tr>
    <!-- Char -->
    <tr>
        <td>Char</td>
        <td>'c'</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "char";
    value = "c";
}
            </pre>
        </td>
        <td>&empty;</td>
    </tr>
    <!-- String -->
    <tr>
        <td>String</td>
        <td>"smth"</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "string";
    value = "smth";
}
            </pre>
        </td>
        <td>"smth"</td>
    </tr>
    <!-- Byte String -->
    <tr>
        <td>Byte String</td>
        <td>b"smth"</td>
        <td colspan='2' align='center'>Not Implemented</td>
    </tr>
    <!-- Optional -->
    <tr>
        <td>Some (Optional)</td>
        <td>Some(...)</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "optional";
    has&lowbar;value = true;
    value = ...;
}
            </pre>
        </td>
        <td>&empty;</td>
    </tr>
    <tr>
        <td>None (Optional)</td>
        <td>None</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "optional";
    has&lowbar;value = false;
    value = null;
}
            </pre>
        </td>
        <td>&empty;</td>
    </tr>
    <!-- Tuple -->
    <tr>
        <td>Tuple (named)</td>
        <td>MyTuple("abc", 42, true)</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "tuple";
    name = "MyTuple";
    value = ["abc", 42, true];
}
            </pre>
        </td>
        <td>&empty;</td>
    </tr>
    <tr>
        <td>Tuple (anonymous)</td>
        <td>("abc", 42, true)</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "tuple";
    name = null;
    value = ["abc", 42, true];
}
            </pre>
        </td>
        <td>&empty;</td>
    </tr>
    <!-- List -->
    <tr>
        <td>List</td>
        <td>["abc", 42, true]</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "list";
    value = ["abc", 42, true];
}
            </pre>
        </td>
        <td>&empty;</td>
    </tr>
    <!-- Struct -->
    <tr>
        <td>Struct (named)</td>
        <td>MyStruct(a: "hello", b: 123)</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "struct";
    name = "MyStruct";
    value = { a: "hello", b: 123 };
}
            </pre>
        </td>
        <td>&empty;</td>
    </tr>
    <tr>
        <td>Struct (anonymous)</td>
        <td>(a: "hello", b: 123)</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "struct";
    name = null;
    value = { a: "hello", b: 123 };
}
            </pre>
        </td>
        <td>&empty;</td>
    </tr>
    <!-- Map -->
    <tr>
        <td>Map</td>
        <td>{ "a": "hello", "b": 123 }</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "map";
    value = [
        { name = "a"; value = "hello"; }
        { name = "b"; value = 123; }
    ];
}
            </pre>
        </td>
        <td>&empty;</td>
    </tr>
    <!-- Unit Value -->
    <tr>
        <td>Unit Value</td>
        <td>SMTH</td>
        <td>
            <pre>
{
    type = "ron";
    kind = "unit";
    value = "SMTH";
}
            </pre>
        </td>
        <td>&empty;</td>
    </tr>
</table>
