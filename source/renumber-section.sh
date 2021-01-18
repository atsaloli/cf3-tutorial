for f in 200-020-Definitions-0130-Body.md 200-020-Definitions-0132-Definition_of_Attribute.md 200-020-Definitions-0135-Promise_Body.md 200-020-Definitions-0140-Promise_Body_example_2.md 200-020-Definitions-0150-Promise_Bundle.md 200-020-Definitions-0152-Promise_Bundle.md 200-020-Definitions-0153-Promise_Bundle.md
do
new_f=`echo $f | sed -e 's:Definitions:Bodies_and_Bundles:'`
git mv $f $new_f
done
#200-020-Definitions-0170-declarative_vs_imperativ_sandwich_example.md
#200-020-Definitions-0180-declarative_vs_imperative.md
#200-020-Definitions-0185-declarative_4_system_admin.md
#200-020-Definitions-0190-Declarative_intent.md
#200-020-Definitions-0200-Convergence.md
#200-020-Definitions-0210-Thinking_Declaratively.md
#200-020-Definitions-0220-Thinking_Declaratively.exr.md
