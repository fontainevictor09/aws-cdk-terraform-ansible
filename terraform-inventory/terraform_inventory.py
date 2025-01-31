import json
import sys
from jinja2 import Environment, FileSystemLoader

def generate_inventory(tfstate_file, template_file, output_file):
    with open(tfstate_file, "r") as file:
        state = json.load(file)

    hosts = []

    # Extraire les instances AWS avec leur IP publique
    for resource in state.get("resources", []):
        if resource["type"] == "aws_instance":
            for instance in resource.get("instances", []):
                attributes = instance.get("attributes", {})
                public_ip = attributes.get("public_ip")
                instance_name = attributes.get("tags", {}).get("Name", f"aws-instance-{instance.get('id', 'unknown')}")

                if public_ip:
                    hosts.append({"name": instance_name, "ip": public_ip})

    # Charger et rendre le template Jinja2
    env = Environment(loader=FileSystemLoader('.'))
    template = env.get_template(template_file)
    inventory_content = template.render(hosts=hosts)

    # Écrire le fichier d'inventaire
    with open(output_file, 'w') as file:
        file.write(inventory_content)

    print(f"Fichier d'inventaire généré avec succès: {output_file}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: terraform_inventory.py <terraform.tfstate> <output_inventory.ini>")
        sys.exit(1)

    tfstate_file = sys.argv[1]
    output_file = sys.argv[2]

    generate_inventory(tfstate_file, "inventory_template.j2", output_file)
