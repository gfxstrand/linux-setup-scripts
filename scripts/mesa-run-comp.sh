_comp_mesa-run() {
  local cur c=1
  COMPREPLY=()

  while [ $c -le $COMP_CWORD ]; do
    case "${COMP_WORDS[c]}" in
    -w)
      c=$((++c))
      if [ $c -eq $COMP_CWORD ]; then
        COMPREPLY=( $( ( cd $HOME/projects/mesa && compgen -d ) ) )
      fi
      break ;;
    -)
      if [ $c -eq $COMP_CWORD ]; then
        COMPREPLY=( $( compgen -W '-w' -- ${COMP_WORDS[c]} ) )
      fi
      break ;;
    *)
      # Something we don't understand.  Use default completion.
      return 1
    esac
    c=$((++c))
  done

  return 0
}

complete -o default -F _comp_mesa-run mesa-run
