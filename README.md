# tractian

This project is my submission to Tractian's [Mobile Software Engineer challenge](https://github.com/tractian/challenges/blob/main/mobile/README.md).

## Example

Here's a short video showcasing the application, where I apply and mix search filters, collapse and expand items and scroll and refresh lists.

https://github.com/user-attachments/assets/31aef6ff-abc3-4db4-a947-ef9acbd2db90

## Design deviations and assumptions

Here are a few points where I deviate from the proposed design and/or take certain liberties:

+ **Refresh**

    No refresh interactions are specified in the proposed design, however given the nature of the application (monitoring assets) I opted to include buttons for refreshing companies and assets, as well as an automatic refresh in the Assets page.

+ **Expand/Collapse**

    It wasn't clear to me whether the application must support expanding/collapsing items, so I opted to include this, given that some datasets might be too long to expect the user to scroll.

+ **Company as root**

    I opted to display the selected company as the root of the tree visualization, so the user can tell which company they're inspecting in the Assets page.

+ **Piping**

    I've taken some liberty in the drawing of the lines that relate items in the tree, which I've chosen to call 'piping'.

## Considerations

Here are a few points about this implementation that I would change, if not for time and scope constraints.

+ **HTTP client encapsulation**
    
    In this implementation a very simple HTTP client is created every time a request is to be done. In a production app, it would be interesting to instantiate a single app-wide HTTP client with more robust capabilities, such as automatic retry and timeout, request/response interception (e.g. for logging) and for header and security settings injection.

+ **Testing**

    No automated tests were developed. Were this a production application, which such critical functionality, a test-driven approach would be best, to ensure no decision is made or alarm is raised based on incorrect data.

+ **Search filters**

    The search filters defined feel a bit rigid, with no option to filter only vibration sensors, or only operational components. Though a simple change, I believe it adds value to the user's experience.
