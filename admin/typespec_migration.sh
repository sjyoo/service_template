ws-url https://kbase.us/services/ws
for t in `ws-typespec-list`; do echo $t; ws-typespec-list $t -spec > $t.spec; done
ws-url http://localhost:7058
for i in `ls`; do m=$(echo $i | sed s/\.spec$//); echo $i $m; ws-typespec-register --user kbasetest --request $m; done
for i in `ls`; do m=$(echo $i | sed s/\.spec$//); echo $i $m; ws-typespec-register --admin "{\"command\":\"approveModRequest\",\"module\":\"$m\"}"; done
for i in `ls *.spec`; do m=$(echo $i | sed s/\.spec$//);  ws-url https://kbase.us/services/ws; l=$(ws-typespec-list $m | sed s/$m.// | sed -r s/-[0-9]\+.[0-9]\+//| tr '\n' ';' | sed "s/;$//"); echo $m $l; ws-url http://localhost:7058; ws-typespec-register --user kbasetest --typespec $i --add "$l"; done
for i in `ls *.spec`; do m=$(echo $i | sed s/\.spec$//);  ws-url https://kbase.us/services/ws; l=$(ws-typespec-list $m | sed s/$m.// | sed -r s/-[0-9]\+.[0-9]\+//| tr '\n' ';' | sed "s/;$//"); echo $m $l; ws-url http://localhost:7058; ws-typespec-register --user kbasetest --typespec $i --add "$l"; done
for i in `ls *.spec`; do m=$(echo $i | sed s/\.spec$//);  ws-url https://kbase.us/services/ws; l=$(ws-typespec-list $m | sed s/$m.// | sed -r s/-[0-9]\+.[0-9]\+//| tr '\n' ';' | sed "s/;$//"); echo $m $l; ws-url http://localhost:7058; ws-typespec-register --user kbasetest --typespec $i --add "$l" --commit; done
for i in `ls`; do m=$(echo $i | sed s/\.spec$//); echo $i $m; ws-typespec-register --user kbasetest --release $m; done
for i in `ls *.spec`; do m=$(echo $i | sed s/\.spec$//);  ws-url https://kbase.us/services/ws; l=$(ws-typespec-list $m | sed s/$m.// | sed -r s/-[0-9]\+.[0-9]\+//| tr '\n' ';' | sed "s/;$//"); echo $m $l; ws-url http://localhost:7058; ws-typespec-register --user kbasetest --typespec $i --add "$l" --commit; done
for i in `ls`; do m=$(echo $i | sed s/\.spec$//); echo $i $m; ws-typespec-register --user kbasetest --release $m; done
for i in `ls *.spec`; do m=$(echo $i | sed s/\.spec$//);  ws-url https://kbase.us/services/ws; l=$(ws-typespec-list $m | sed s/$m.// | sed -r s/-[0-9]\+.[0-9]\+//| tr '\n' ';' | sed "s/;$//"); echo $m $l; ws-url http://localhost:7058; ws-typespec-register --user kbasetest --typespec $i --add "$l" --commit; done
for i in `ls`; do m=$(echo $i | sed s/\.spec$//); echo $i $m; ws-typespec-register --user kbasetest --release $m; done
