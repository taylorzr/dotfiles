import os
from sys import stdout

import requests

query = """
query($org: String!, $cursor: String) {
    organization(login: $org) {
        repositories(first: 100, after: $cursor) {
            nodes {
                name
                sshUrl
                }
            pageInfo {
                endCursor
                startCursor
                hasNextPage
            }
        }
    }
}
"""


def run_query(
    query, org=os.getenv("GITHUB_ORG"), cursor=None
):  # A simple function to use requests.post to make the API call. Note the json= section.
    data = {"query": query, "variables": {"org": org, "cursor": cursor}}
    request = requests.post(
        "https://api.github.com/graphql",
        json=data,
        headers={"Authorization": f"Bearer {os.getenv('GITHUB_TOKEN')}"},
    )
    if request.status_code == 200:
        return request.json()
    else:
        raise Exception(
            "Query failed to run by returning code of {}. {}".format(
                request.status_code, query
            )
        )


cursor = None
repos = []

while True:
    result = run_query(query, cursor=cursor)

    for repo in result["data"]["organization"]["repositories"]["nodes"]:
        print(repo["name"], repo["sshUrl"])
    stdout.flush()  # so that results show in fzf sooner

    pageInfo = result["data"]["organization"]["repositories"]["pageInfo"]
    if not pageInfo["hasNextPage"]:
        break
    cursor = pageInfo["endCursor"]
